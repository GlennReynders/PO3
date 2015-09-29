within PO3_basics.Data.Insulation;
record Ytong = PO3_basics.Data.Interfaces.Insulation (
    k=0.120,
    c=1000,
    rho=450,
    epsLw=0.8,
    epsSw=0.8) "Ytong";
