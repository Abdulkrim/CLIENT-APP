import '../entity/device.dart';
import 'device_data_response.dart';

class DevicesResponse {
  List<DeviceDataResponse> devices;

  DevicesResponse.fromJson(List<dynamic> json)
      : devices = json.map((e) => DeviceDataResponse.fromJson(e)).toList();

  List<Device> toEntity() =>
      devices.map((e) => Device(id: e.id ?? 0, name: e.name ?? '', image: e.logo ?? '')).toList();
}
