within PO3_basics.Data.Materials;
record Timber = PO3_basics.Data.Interfaces.Material (
    k=0.11,
    c=1880,
    rho=550,
    epsLw=0.86,
    epsSw=0.44) "Timber finishing";
