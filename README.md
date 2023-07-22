# GFIOT iOS接入指南

### 1.CocoaPods 集成(推荐)

Podfile增加
###### Objective-C工程使用:
```
pod "GFIOT", :git => "https://github.com/GoFun-Tech/GFIOT-iOS.git"
```

###### Swift工程使用:
```
pod "GFIOT", :git => "https://github.com/GoFun-Tech/GFIOT-iOS.git", :branch => 'XC-xxx'
```
`xxx`表示Xcode版本, 如Xcode版本为`13.2`, Podfile则写为
```
pod "GFIOT", :git => "https://github.com/GoFun-Tech/GFIOT-iOS.git", :branch => 'XC-13.2'
```

执行`pod install`后即可使用

### 2.手动接入
###### Objective-C工程手动接入:
将`GFIOTSDK`文件夹导入项目

###### Swift工程手动接入:
将`GFIOTSDK-xxx`文件夹导入项目
* `xxx`表示Xcode版本号
* 
* 如Xcode版本为`13.2`,则导入`GFIOTSDK-13.2`文件夹


###### GFIOTSDK文件夹结构:
> GFIOTSDK
>> GFIOT-Description.swift
>>
>> GFIOT.framework


### 3.工程配置
在`Info.plist`文件增加`Privacy - Bluetooth Always Usage Description`使用蓝牙说明。

![添加隐私声明](https://imgpub1.shouqiev.com/gofunplatform/files/20230721/duUoubDOIf.png)

### 4.编写集成代码
#### 4.1 Swfit代码
##### 4.1.1 初始化SDK
在获取到`accessToken`之后调用以下代码。
```
import GFIOT

GFIOT.initSDK(accessToken, isDebug: true ,callback: { (code, result) in
    
})
```
`isDebug`不传值,则默认为`false`,即使用正式环境。

##### 4.1.2 控制车辆
```
import GFIOT

GFIOT.control(deviceId, command, callback: { code, result in

})
```
* `deviceId`为需要控制的车机id
* `command`为下发的指令

#### 4.2 Objective-C代码
##### 4.2.1 初始化SDK
在获取到`accessToken`之后调用以下代码。
```
#import <GFIOT/GFIOT-Swift.h>

[GFIOT initSDK:accessToken isDebug:YES callback:^(NSInteger code, GFIOT_RESULT * _Nonnull result) {
            
}];
```
`isDebug`不传值,则默认为`NO`,即使用正式环境。

##### 4.2.2 控制车辆
```
#import <GFIOT/GFIOT-Swift.h>

[GFIOT control:deviceId :GFIOT_CONTROL_POWER_ON callback:^(NSInteger code, GFIOT_RESULT * _Nonnull result) {
        
}];
```
* `deviceId`为需要控制的车机id
* `command`为下发的指令


### 5.回调说明
|字段|说明|
|--|--|
|code|错误码|
|result|回调详细数据|
|message|回调说明|
|deviceId|车机id(只有控制车辆方法才有值)|

result结构
###### Swift
```
public class GFIOT_RESULT: NSObject {
    public var message: String = ""
    public var deviceId: String?
}
```
###### Objective-C
```
@interface GFIOT_RESULT: NSObject 

@property(copy, nonatomic) NSString *message;
@property(copy, nonatomic) NSString *deviceId;

@end

```

##### code说明
|init时code|说明|
|--|--|
|200|初始化成功 init时回调|
|其他|apikey无效|

|control时code|说明|
|--|--|
|300|指令操作成功|
|30000|蓝牙未开启|
|30001|连接设备失败|
|30002|车机版本低，不支持此命令|
|30003|车机命令超时或未响应|
|30004|控制指令异常 message中有具体说明|
|30005|车辆未熄火，请在车辆熄火后执行|
|30006|车门未关闭|
|30007|车灯未关闭|
|30008|请勿重复操作（前一个操作未完成，又执行下一个控制时触发）|


### 下载SDK
###### Objective-C工程使用
[下载地址]()

###### Swift工程使用
[Xcode13.2版本-Swift5.7.2]()

[Xcode13.3版本-Swift5.8.2]()
