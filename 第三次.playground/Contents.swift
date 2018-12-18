import UIKit

var str = "Hello, playground"

func getDate(date: Date, zone: Int = 0) -> String {
    let formatter = DateFormatter()  //实例化格式化类
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"  //指定格式化的格式
    formatter.locale = Locale.current  //设置当前位置，可以将对应的星期数和12小时制的上下午设置为中文
    if zone >= 0 { //当传入的为正数时，在东半区
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(zone):00")
    } else {  //当传入的为负数时，在西半区
        formatter.timeZone = TimeZone(abbreviation: "UTC\(zone):00")
    }
    
    let dateString = formatter.string(from: now)  //将传入的日期格式化为字符串
    return dateString
}

let now = Date()  //获取当前时间日期

let beijing = getDate(date: now, zone: +8)  //获取当前北京的时间
print("北京: \(beijing)")  //输出: 北京: 2017年09月19日星期二 下午 10:56

let tokyo = getDate(date: now, zone: 9)  //获取当前东京的时间
print("东京: \(tokyo)")  //输出: 东京: 2017年09月19日星期二 下午 11:56

let newYork = getDate(date: now, zone: -5)  //获取当前纽约的时间
print("纽约: \(newYork)")  //输出: 纽约: 2017年09月19日星期二 上午 09:56

let london = getDate(date: now)  ////获取当前伦敦的时间
print("伦敦: \(london)")  //输出: 伦敦: 2017年09月19日星期二 下午 02:56








var dic = ["beijing":beijing,"tokyo":tokyo,"newYork":newYork,"london":london,"str":str]
print(dic)
let fileManager=FileManager.default
var url=fileManager.urls(for:.documentDirectory,in:.userDomainMask).first!
url.appendPathComponent("test.txt")
let dic1 = dic as!  AnyObject
try? dic1.write(to:url,atomically:true)
// var ss="hello"
// try? ss.write(to:url)








// guard let weatherUrl=URL(string: "http://wthrcdn.etouch.cn/weather_mini?city=北京市")else{
//   /// throw MyError.NotURL
// }
// let jsondata=try! Data(contentsOf:weatherUrl)
// let json=try! JSONSerialization.jsonObject(with:jsondata,options:.allowFragments)
// guard let dic=json as? [String:Any] else{
//   // throw MyError.NotURL
// }
// guard let weather=dic["data"] as? [String:String] else{
//   //  throw MyError.NotURL
// }
// let temp1=weather["wendu"]
// print(temp1!)

enum MyError:Error{
    case Zero
    case NotURL
}
guard let weatherUrl = URL(string: "http://www.weather.com.cn/data/cityinfo/101010100.html")
    else{
        throw MyError.NotURL
}
let jsondate = try! Data(contentsOf: weatherUrl)
let json = try! JSONSerialization.jsonObject(with: jsondate, options: .allowFragments)
print(json)
//把json文件转化为字典
guard let dictionary = json as?[String:Any] else{
    throw MyError.NotURL
}
guard let weather = dictionary["weatherinfo"] as? [String:String] else{
    throw MyError.NotURL
}
print(weather)
let temp1 = weather["temp1"]
print(temp1!)
