within PO3_basics;
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
end Systems;
