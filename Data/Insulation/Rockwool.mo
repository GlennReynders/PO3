within PO3.Data.Insulation;
record Rockwool = PO3.Data.Interfaces.Insulation (
    final k=0.036,
    final c=840,
    final rho=110,
    final epsLw=0.8,
    final epsSw=0.8) "Rockwool";
