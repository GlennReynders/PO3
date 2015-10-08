within PO3.Data.Materials;
record Screed = PO3.Data.Interfaces.Material (
    k=0.6,
    c=840,
    rho=1100,
    epsLw=0.88,
    epsSw=0.55) "Light cast concrete";
