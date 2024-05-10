class Thermometer{

  int deviceID = 0;
  String name = '';
  double temperature = 0;
  double humidity = 0;
  bool isOnline = false;

  Thermometer(this.deviceID, this.name, this.temperature, this.humidity, this.isOnline);

  Map<String, dynamic> toJson() => {
    'deviceID': deviceID,
    'name': name,
    'temperature': temperature,
    'humidity': humidity,
    'isOnline': isOnline
  };

  void setName(newName){
    name = newName;
  }

  String getName(){
    return name;
  }

  void setOnline(bool newValue){
    isOnline = newValue;
  }

  bool getOnline(){
    return isOnline;
  }

  void setTemperature(double newTemperature){
    temperature = newTemperature;
  }

  double getTemperature(){
    return temperature;
  }

  void setHumidity(double newHumidity){
    humidity = newHumidity;
  }

  double getHumidity(){
    return humidity;
  }

  void setDeviceID(int newDeviceID){
    deviceID = newDeviceID;
  }

  int getDeviceID(){
    return deviceID;
  }

  @override
  String toString() {
    return 'Thermometer{deviceID: $deviceID, name: $name, temperature: $temperature, humidity: $humidity, isOnline: $isOnline}';
  }

}