# GFIOT
[简体中文](./README_CN.md) | English
## Install GFIOT

### 1.CocoaPods

Add the pod to your `Podfile`:
```
pod "GFIOT", :git => "https://github.com/GoFun-Tech/GFIOT-iOS.git", :branch => 'XC-xxx'
```
`xxx` means your Xcode version number, if Xcode version number is `14.2`, add the pod to your `Podfile`
```
pod "GFIOT", :git => "https://github.com/GoFun-Tech/GFIOT-iOS.git", :branch => 'XC-14.2'
```

And then run:

```
pod install
```

### 2.Manually import the SDK

Import the `GFIOTSDK-xxx` folder into your project
* `xxx`means your Xcode version number
* 
* if Xcode version number is `14.2`, import the `GFIOTSDK-14.2`folder into your project

download GFIOT SDK
[GFIOT-Xcode14.2](https://imgpub1.shouqiev.com/gofunplatform/files/20230809/putqvKUGpu.zip)

[GFIOT-Xcode14.3.1](https://imgpub1.shouqiev.com/gofunplatform/files/20230809/ZlCXCcFHlS.zip)


###### GFIOTSDK folder structure:
> GFIOTSDK
>> GFIOT-Description.swift
>>
>> GFIOT.framework


### 3.project setting
Add the key to your `Info.plist`
```
Privacy - Bluetooth Always Usage Description
```
And add use description


![添加隐私声明](https://imgpub1.shouqiev.com/gofunplatform/files/20230721/duUoubDOIf.png)

### 4.Edit Code
#### 4.1 Swfit
##### 4.1.1 Init SDK
First get `accessToken` by your service, than use the `accessToken` call this function.

```
import GFIOT

GFIOT.initSDK(accessToken, isDebug: true ,callback: { (code, result) in
    
})
```
`isDebug`: whether to use the debug environment, defaults to `false`

##### 4.1.2 Control
```
import GFIOT

GFIOT.control(deviceId, .OPEN_DOOR, callback: { code, result in

})
```
* `deviceId`: control device id

###### Swift command enum
|command|description|
|--|--|
|OPEN_DOOR|Open the door|
|CLOSE_DOOR|Close the door|
|OPEN_DOOR_AND_POWER|Power on and open the door|
|CLOSE_DOOR_AND_POWER|Power off and close the door|
|POWER_ON|Power on|
|POWER_OFF|Power off|


#### 4.2 Objective-C
##### 4.2.1 Init SDK
First get `accessToken` by your service, than use the `accessToken` call this function.
```
#import <GFIOT/GFIOT-Swift.h>

[GFIOT initSDK:accessToken isDebug:YES callback:^(NSInteger code, GFIOT_RESULT * _Nonnull result) {
            
}];
```
`isDebug`: whether to use the debug environment.

##### 4.2.2 Control
```
#import <GFIOT/GFIOT-Swift.h>

[GFIOT control:deviceId :GFIOT_CONTROL_POWER_ON callback:^(NSInteger code, GFIOT_RESULT * _Nonnull result) {
        
}];
```
* `deviceId`: control device id
###### Objective-C command enum
|command|description|
|--|--|
|GFIOT_CONTROL_OPEN_DOOR|Open the door|
|GFIOT_CONTROL_CLOSE_DOOR|Close the door|
|GFIOT_CONTROL_OPEN_DOOR_AND_POWER|Power On and open the door|
|GFIOT_CONTROL_CLOSE_DOOR_AND_POWER|Power Off and close the door|
|GFIOT_CONTROL_POWER_ON|Power On|
|GFIOT_CONTROL_POWER_OFF|Power Off|


### 5.Call back info
|property|description|
|--|--|
|code|Error Code|
|result|Call back description|
|message|Call back message|
|deviceId|Only exists in the control function|

##### 5.1 Result 
###### 5.1.1 Swift
```
public class GFIOT_RESULT: NSObject {
    public var message: String = ""
    public var deviceId: String?
}
```
###### 5.1.2 Objective-C
```
@interface GFIOT_RESULT: NSObject 

@property(copy, nonatomic) NSString *message;
@property(copy, nonatomic) NSString *deviceId;

@end

```

##### 5.2 Code 
|Init return the code|Description|
|--|--|
|200|Success|
|other|`assesToken` invalid|


|Control return the code|Description|
|--|--|
|200|Success|
|30000|Bluetooth not turned on|
|30001|Bluetooth connect failed|
|30002|This command is not supported|
|30003|Time out|
|30004|Command error|
|30005|The vehicle is not turned off|
|30006|The door is not closed|
|30007|Lights not turned off|
|30008|Do not repeat|



