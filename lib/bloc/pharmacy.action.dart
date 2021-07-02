abstract class PharmaciesEvent{
  String payload;
  PharmaciesEvent(this.payload);
}
class LoadAllPharmaciesEvents extends PharmaciesEvent{
  LoadAllPharmaciesEvents(String payload):super(payload);
}
class LoadPharmaciesBylocationEvents extends PharmaciesEvent{
    LoadPharmaciesBylocationEvents(String payload):super(payload);
}
class LoadPharmaciesBySearchName extends PharmaciesEvent{
  LoadPharmaciesBySearchName(String payload) : super(payload);
  

  
}
// class LoadDevelopersEvents extends PharmaciesEvent{}