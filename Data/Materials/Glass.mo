within PO3_basics.Data.Materials;
record Glass = PO3_basics.Data.Interfaces.Material (
    k=0.96,
    c=750,
    rho=2500,
    epsLw=0.84,
    epsSw=0.67) "Glass";
