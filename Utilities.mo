within PO3;
package Utilities

  model AmbientTemperature "Connector for ambient temperature"

    outer IDEAS.SimInfoManager sim
      "Simulation information manager for climate data"
      annotation (Placement(transformation(extent={{-200,80},{-180,100}})));

    Modelica.Blocks.Interfaces.RealOutput Te annotation (Placement(transformation(
            extent={{90,-8},{110,12}}), iconTransformation(extent={{90,-8},{110,12}})));

  equation
    sim.Te=Te;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Text(
            extent={{66,-60},{-72,72}},
            lineColor={28,108,200},
            textString="Te [K]")}));
  end AmbientTemperature;
end Utilities;
