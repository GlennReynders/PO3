within PO3_basics.Data.Insulation;
record Xps = PO3_basics.Data.Interfaces.Insulation (
    k=0.024,
    c=1470,
    rho=40,
    epsLw=0.8,
    epsSw=0.8) "Extruded polystrene, XPS";
