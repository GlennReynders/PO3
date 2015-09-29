within PO3_basics.Data.Materials;
record Gypsum = PO3_basics.Data.Interfaces.Material (
    k=0.6,
    c=840,
    rho=975,
    epsLw=0.85,
    epsSw=0.65) "Gypsum plaster for finishing";
