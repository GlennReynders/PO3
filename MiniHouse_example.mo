within PO3_basics;
model MiniHouse_example "Basemodel for mini passivehouse"

  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    V=1,
    nSurf=3) annotation (Placement(transformation(extent={{-38,-42},{8,4}})));
  Systems.HeatingSystem heatingSystem(nZones=1, QNom={25})
    annotation (Placement(transformation(extent={{48,-12},{88,8}})));
  Modelica.Blocks.Sources.Constant TSet(k=273.15 + 22)
    annotation (Placement(transformation(extent={{38,-72},{58,-52}})));
  IDEAS.Buildings.Components.OuterWall roof(
    insulationThickness=0.1,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
    AWall=5,
    inc=1.5707963267949,
    azi=1.5707963267949)
    annotation (Placement(transformation(extent={{-94,22},{-84,42}})));
  Systems.VentilationSystem none(
    nZones=1,
    VZones={zone.V},
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    nLoads=0) annotation (Placement(transformation(extent={{30,64},{70,84}})));
  IDEAS.Buildings.Components.OuterWall wall(
    insulationThickness=0.1,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
    AWall=5,
    inc=1.5707963267949,
    azi=1.5707963267949)
    annotation (Placement(transformation(extent={{-94,-10},{-84,10}})));
  IDEAS.Buildings.Components.Window window(
    inc=1.5707963267949,
    azi=0,
    A=1,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2ArNature glazing,
    redeclare IDEAS.Buildings.Data.Frames.None fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    annotation (Placement(transformation(extent={{-92,-44},{-82,-24}})));
  Utilities.AmbientTemperature ambientTemperature
    annotation (Placement(transformation(extent={{20,16},{40,32}})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=1) "kg/s"
    annotation (Placement(transformation(extent={{4,36},{24,56}})));
equation
  connect(zone.TSensor, heatingSystem.TSensor[1]) annotation (Line(points={{9.38,
          -19},{9.38,-18},{44,-18},{44,-8},{47.6,-8}}, color={0,0,127}));
  connect(heatingSystem.heatPortCon[1], zone.gainCon) annotation (Line(points={{
          48,0},{40,0},{28,0},{28,-25.9},{8,-25.9}}, color={191,0,0}));
  connect(zone.gainRad, heatingSystem.heatPortRad[1]) annotation (Line(points={{
          8,-32.8},{16,-32.8},{36,-32.8},{36,-4},{48,-4}}, color={191,0,0}));
  connect(TSet.y, heatingSystem.TSet[1])
    annotation (Line(points={{59,-62},{68,-62},{68,-12.2}}, color={0,0,127}));
  connect(zone.TSensor, heatingSystem.mDHW60C) annotation (Line(points={{9.38,-19},
          {46,-19},{46,-34},{74,-34},{74,-12.2}}, color={0,0,127}));
  connect(roof.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-84,36},{-60,36},{-60,-10},{-38,-10},{-38,-6.73333}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.flowPort_Out, none.flowPort_In[1]) annotation (Line(points={{-19.6,
          4},{-20,4},{-20,76},{30,76}}, color={0,0,0}));
  connect(zone.flowPort_In, none.flowPort_Out[1]) annotation (Line(points={{-10.4,
          4},{-10,4},{-10,26},{-8,26},{-8,72},{30,72}}, color={0,0,0}));
  connect(zone.TSensor, none.TSensor[1]) annotation (Line(points={{9.38,-19},{20,
          -19},{20,12},{-2,12},{-2,68},{29.6,68}}, color={0,0,127}));
  connect(wall.propsBus_a, zone.propsBus[2]) annotation (Line(
      points={{-84,4},{-64,4},{-64,-8},{-38,-8},{-38,-9.8}},
      color={255,204,51},
      thickness=0.5));
  connect(window.propsBus_a, zone.propsBus[3]) annotation (Line(
      points={{-82,-30},{-68,-30},{-68,-26},{-38,-26},{-38,-12.8667}},
      color={255,204,51},
      thickness=0.5));
  connect(ambientTemperature.Te, none.Tsup[1]) annotation (Line(points={{40,24.16},
          {46,24.16},{46,63.6},{46.2,63.6}}, color={0,0,127}));
  connect(m_flow_set.y, none.m_flow_Set[1])
    annotation (Line(points={{25,46},{38.4,46},{38.4,64}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end MiniHouse_example;
