within PO3_basics.Data.Materials;
record Ground = PO3_basics.Data.Interfaces.Material (
    final k=2.0,
    final c=1250,
    final rho=1600,
    final epsLw=0.88,
    final epsSw=0.68);
