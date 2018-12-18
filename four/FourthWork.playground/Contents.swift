//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

//第一题
let fileManager = FileManager.default
let docPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.path

var file = docPath?.appending("/yls")
if fileManager.fileExists(atPath: file!) {
    let image = file?.appending("/my.jpg")
    if fileManager.fileExists(atPath: image!){
        print("存在")
    }
    else{
        let url = URL(string:"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1544690593&di=f8e3db54a423deae3d12ba1ba6751df5&src=http://pic1.win4000.com/wallpaper/2018-01-25/5a699c51974c7.jpg")
        let data = try Data(contentsOf: url!)
        try data.write(to:URL(fileURLWithPath: image!),options: .atomicWrite)
    }
}
else{
    try fileManager.createDirectory(atPath: file!, withIntermediateDirectories: true, attributes: nil)
    print("文件不存在，创建文件")
}


//第二、三题
class MyView:UIView{
    override func  draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setStroke()//绿色边框
        path.stroke()
        UIColor.blue.setFill()//填充
        path.fill()
    }
}

class Controller:UIViewController{
    var label:UILabel!
    var circle:MyView!
    override func loadView() {
        view = UIView(frame:CGRect(x:0,y:0,width:400,height:1000))
        view.backgroundColor=UIColor.yellow
        //创建圆
        let circle = MyView(frame:CGRect(x:100,y:300,width:200,height:100))
        circle.backgroundColor = UIColor.clear
        view.addSubview(circle)
        
        
        label = UILabel(frame: CGRect(x:100,y:20,width:200,height:50))
        label.backgroundColor=UIColor.yellow
        label.textColor=UIColor.black
        label.textAlignment = .center
        label.text = "hello world"
        view.addSubview(label)
        
        
        let botton = UIButton(frame: CGRect(x:100,y:550,width:200,height:50))
        botton.backgroundColor = UIColor.blue
        botton.setTitle("Click Me", for: .normal)
        
        botton.addTarget(self, action: #selector(Controller.clicked), for: .touchUpInside)
        view.addSubview(botton)
        
    }
    @IBAction func clicked(){
        print("hello yls")
        label?.text = "hello yls"
        UIView.animate(withDuration: 1){
            self.circle.center = CGPoint(x:200,y:0)
        }
        
    }
}


let myCon = Controller()
PlaygroundPage.current.liveView = myCon


