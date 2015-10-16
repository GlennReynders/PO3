within PO3;
package Systems

  model HeatingSystem
    extends IDEAS.HeatingSystems.IdealRadiatorHeating(nLoads=0,COP=1,InInterface=true,
      Q_design={150});

  end HeatingSystem;

  model VentilationSystem
    "Ideal ventilation with controlled supply temperature and massflow rate"
    extends IDEAS.Interfaces.BaseClasses.VentilationSystem(nLoads=0);

    Modelica.Blocks.Interfaces.RealInput[nZones] m_flow_Set annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-116,-100})));
    IDEAS.Fluid.Sources.MassFlowSource_T
                                   sou[nZones](
      each use_m_flow_in=true,
      each final nPorts=1,
      redeclare each package Medium = Medium,
      each use_T_in=true) "Source"
      annotation (Placement(transformation(extent={{-142,22},{-162,42}})));
    IDEAS.Fluid.Sources.FixedBoundary
                                sink[nZones](
                           each final nPorts=1, redeclare each package Medium
        =                                                                       Medium)
      annotation (Placement(transformation(extent={{-142,-18},{-162,2}})));
    Modelica.Blocks.Interfaces.RealInput[nZones] Tsup annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-38,-104})));
  equation
    P[1:nLoads_min] = zeros(nLoads_min);
    Q[1:nLoads_min] = zeros(nLoads_min);

    connect(flowPort_Out[:], sou[:].ports[1]);
    connect(flowPort_In[:], sink[:].ports[1]);

    connect(Tsup, sou.T_in) annotation (Line(points={{-38,-104},{-34,-104},{-34,14},
            {-140,14},{-140,36}}, color={0,0,127}));
    connect(m_flow_Set, sou.m_flow_in) annotation (Line(points={{-116,-100},{-100,
            -100},{-100,-42},{-96,-42},{-96,40},{-142,40}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
              -100},{200,100}})));
  end VentilationSystem;

  model ElectricRadiatior "Electric radiators, on/off, no DHW"
    extends IDEAS.HeatingSystems.Interfaces.Partial_IdealHeating;
    extends IDEAS.Interfaces.BaseClasses.HeatingSystem(
      final isHea = true,
      final isCoo = false,
        nConvPorts = nZones,
        nRadPorts = nZones,
        nTemSen = nZones,
        nEmbPorts=0,
      nLoads=1);

    IDEAS.HeatTransfer.HeatCapacitor[nZones] heatCapacitor(C=QNom/10)
      annotation (Placement(transformation(extent={{-66,-60},{-46,-40}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] PowerSupply
      annotation (Placement(transformation(extent={{-8,-74},{-34,-48}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature[nZones]
      prescribedTemperature
      annotation (Placement(transformation(extent={{-142,-70},{-122,-50}})));
    IDEAS.HeatTransfer.ThermalResistor[nZones] thermalResistor(R=QNom/40)
      annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor[nZones] Qheat
      annotation (Placement(transformation(extent={{-94,-70},{-114,-50}})));
    Modelica.Blocks.Logical.OnOffController[nZones] onOffController(bandwidth=
          0.5)
      annotation (Placement(transformation(extent={{72,-62},{62,-52}})));
    Modelica.Blocks.Math.BooleanToReal[nZones] booleanToReal
      annotation (Placement(transformation(extent={{52,-66},{40,-54}})));
    Modelica.Blocks.Math.Gain[nZones] gain(k=QNom)
      annotation (Placement(transformation(extent={{18,-66},{8,-56}})));
  equation
  QHeatZone=Qheat.Q_flow;
    for i in 1:nZones loop

       heatPortRad[i].Q_flow = -fractionRad[i]*QHeatZone[i];
       heatPortCon[i].Q_flow = -(1 - fractionRad[i])*QHeatZone[i];
    end for;
    QHeaSys = sum(QHeatZone);

    P[1] = QHeaSys/COP;
    Q[1] = 0;
    connect(heatCapacitor.port, PowerSupply.port)
      annotation (Line(points={{-56,-60},{-34,-60},{-34,-61}}, color={191,0,0}));
    connect(TSensor, prescribedTemperature.T) annotation (Line(points={{-204,-60},
            {-204,-60},{-162,-60},{-144,-60}}, color={0,0,127}));
    connect(heatCapacitor.port, thermalResistor.port_b)
      annotation (Line(points={{-56,-60},{-70,-60}}, color={191,0,0}));
    connect(prescribedTemperature.port, Qheat.port_b) annotation (Line(points={{-122,
            -60},{-120,-60},{-114,-60}}, color={191,0,0}));
    connect(Qheat.port_a, thermalResistor.port_a)
      annotation (Line(points={{-94,-60},{-94,-60},{-90,-60}}, color={191,0,0}));
    connect(onOffController.reference, TSet) annotation (Line(points={{73,-54},
            {102,-54},{102,-82},{20,-82},{20,-104}}, color={0,0,127}));
    connect(onOffController.u, prescribedTemperature.T) annotation (Line(points={{
            73,-60},{80,-60},{80,-80},{-182,-80},{-182,-60},{-144,-60}}, color={0,
            0,127}));
    connect(onOffController.y, booleanToReal.u) annotation (Line(points={{61.5,-57},
            {58,-57},{58,-60},{53.2,-60}}, color={255,0,255}));
    connect(booleanToReal.y, gain.u) annotation (Line(points={{39.4,-60},{30,-60},
            {30,-61},{19,-61}}, color={0,0,127}));
    connect(PowerSupply.Q_flow, gain.y)
      annotation (Line(points={{-8,-61},{0,-61},{7.5,-61}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p><b>Description</b> </p>
<p>Ideal heating (no hydraulics) but with limited power <i>QNom</i> per zone. There are no radiators. This model assumes a thermal inertia of each zone and computes the heat flux that would be required to heat up the zone to the set point within a time <i>t</i>. This heat flux is limited to <i>QNom</i> and splitted in a radiative and a convective part which are imposed on the heatPorts <i>heatPortRad</i> and <i>heatPortCon</i> respectively. A COP can be passed in order to compute the electricity consumption of the heating.</p>
<p><u>Note</u>: the responsiveness of the system is influenced by the time constant <i>t</i>.  For small values of<i> t</i>, this system is close to ideal, but for larger values, there may still be deviations between the zone temperature and it&apos;s set point. </p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>No inertia; responsiveness modelled by time constant <i>t</i> for reaching the temperature set point. </li>
<li>Limited output power according to <i>QNom[nZones]</i></li>
<li>Heat emitted through <i>heatPortRad</i> and <i>heatPortCon</i> </li>
</ol></p>
<p><h4>Model use</h4></p>
<p><ol>
<li>Connect the heating system to the corresponding heatPorts of a <a href=\"modelica://IDEAS.Interfaces.BaseClasses.Structure\">structure</a>. </li>
<li>Connect <i>TSet</i> and <i>TSensor</i> </li>
<li>Connect <i>plugLoad </i>to an inhome grid. A<a href=\"modelica://IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder\"> dummy inhome grid like this</a> has to be used if no inhome grid is to be modelled. </li>
<li>Set all parameters that are required. </li>
</ol></p>
<p><h4>Validation </h4></p>
<p>No validation performed.</p>
<p><h4>Example </h4></p>
<p>An example of the use of this model can be found in<a href=\"modelica://IDEAS.Thermal.HeatingSystems.Examples.IdealRadiatorHeating\"> IDEAS.Thermal.HeatingSystems.Examples.IdealRadiatorHeating</a>.</p>
</html>",   revisions="<html>
<p><ul>
<li>2013 June, Roel De Coninck: reworking interface and documentation</li>
<li>2011, Roel De Coninck: first version</li>
</ul></p>
</html>"),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,100}}),
          graphics));
  end ElectricRadiatior;
end Systems;
