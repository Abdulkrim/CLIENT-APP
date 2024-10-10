final class Device{
  final int id;
  final String name;
  final String image;

  const Device({required this.id, required this.name, required this.image});


  Device.firstItem(): id= 0 , name ='Select one' , image = '';
}