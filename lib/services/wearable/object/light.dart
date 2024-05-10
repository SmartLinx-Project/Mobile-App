class Light{

  int deviceID = 0;
  String name = '';
  bool state = false;
  bool isOnline = false;

  Light(this.deviceID, this.name, this.state, this.isOnline);

  Map<String, dynamic> toJson() =>
      {'deviceID': deviceID, 'name': name, 'state': state, 'isOnline': isOnline};

  void setName(newName){
    name = newName;
  }

  void setState(bool newState){
    state = newState;
  }

  String getName(){
    return name;
  }

  bool getState(){
    return state;
  }

  void setOnline(bool newValue){
    isOnline = newValue;
  }

  bool getOnline(){
    return isOnline;
  }

  void setDeviceID(int newDeviceID){
    deviceID = newDeviceID;
  }

  int getDeviceID(){
    return deviceID;
  }

  @override
  String toString() {
    return 'Light{deviceID: $deviceID, name: $name, state: $state, isOnline: $isOnline}';
  }
}