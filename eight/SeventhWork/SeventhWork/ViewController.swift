//
//  ViewController.swift
//  SeventhWork
//
//  Created by student on 2018/11/21.
//  Copyright © 2018年 yls. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    /*
     *   属性声明
     */
    //学生数组
    var stuArr = [Student]()
    //教师数组
    var teaArr = [Teacher]()
    //定义一个表头数组
    var tableTitle = ["Teacher","Student"]
    //定义一个表视图
    var table: UITableView!
    //右边按钮
    var rightItem: UIBarButtonItem!
    //弹出框
    var alert: UIAlertController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "table"
        self.view.backgroundColor = UIColor.yellow
        
        //生成对象
        for i in 1...4{
            let temp = Teacher(title: "教授", firstName: "张", lastName: "三", age: 30+i, gender: Gender.male, department: .one)
            teaArr.append(temp)
        }
        for i in 1...4{
            let temp = Student(stuNo: 2016000+i, firstName: "李", lastName: "四", age: 18, gender: Gender.male, department: .one)
            stuArr.append(temp)
        }
        
        //创建表视图，并设置代理和数据源
        table = UITableView(frame: self.view.bounds)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        
        //导航栏控制器右边的按钮
        rightItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = rightItem
        //导航栏控制器左边的按钮
        let leftItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addStu))
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        
    }
    
    //编辑
    @objc func edit(){
        if table.isEditing {
            rightItem.title = "编辑"
            table.isEditing = false
        } else {
            rightItem.title = "完成"
            table.isEditing = true
        }
        
    }
    
    //删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    //更改一下滑动出来的删除按钮显示的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    //删除的实现
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            if indexPath.section == 0 {
                teaArr.remove(at: indexPath.row)
            } else {
                stuArr.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    //添加弹出框
    @objc func addStu() {
        //弹出框
        alert = UIAlertController(title: "信息添加", message:  "请添加入学生信息！", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "学号"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "姓"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "名"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "性别"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "年龄"
        }
        let OKBtn = UIAlertAction(title: "确定", style: .default) { (alert) in
            self.add()
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(OKBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //添加的实现
    func add() {
        let  num = Int(alert.textFields![0].text!)
        let firstName = alert.textFields![1].text!
        let lastName = alert.textFields![2].text!
        let gender: Gender
        switch alert.textFields![3].text! {
        case "男":
            gender = .male
        case "女":
            gender = .female
        default:
            gender = .unknow
        }
        let age = Int(alert.textFields![4].text!)
        let stu = Student(stuNo: num!, firstName: firstName, lastName: lastName, age: age!, gender: gender, department: Department.one)
        stuArr.append(stu)
        
        //重新加载数据
        table.reloadData()
    }
    
    
    //指定section的值
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitle.count         //即return 2
    }
    //修改section中textlable的样式
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return}
        header.textLabel?.textColor = UIColor.orange
    }
    
    //指定每个section的头，提示一些信息来方便用户使用
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitle[section]      //即返回tableTitle中的值
    }
    
    /*
     *   有两种信息需要展示，所以做了两个section，分别返回两个section的行数
     */
    //指定表视图中单元格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teaArr.count
        } else {
            return stuArr.count
        }
    }
    
    //指定表视图中单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //定义一个常量用于单元格的重用
        let identifier = tableTitle[indexPath.section]
        //根据不同的identifier的值从队列中取出单元格
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        //初始化cell
        if cell == nil{
            /*
            //使Teacher和Student的单元格都显示子标题
            let style:UITableViewCell.CellStyle = (identifier == "Teacher" || identifier == "Student") ? .subtitle:.default
            */
            //使Teacher单元格显示子标题
            let style:UITableViewCell.CellStyle = (identifier == "Teacher") ? .subtitle:.default
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
            cell?.backgroundColor = .yellow
            //设置accessoryType属性
            cell?.accessoryType = .disclosureIndicator
        }
        
        switch identifier {
        case "Teacher":
            cell?.textLabel?.text = teaArr[indexPath.row].fullName
            cell?.detailTextLabel?.text = teaArr[indexPath.row].title
        case "Student":
            cell?.textLabel?.text = stuArr[indexPath.row].fullName
            //cell?.detailTextLabel?.text = "\(stuArr[indexPath.row].stuNo)"
        default:
            break
        }
        
        return cell!
    }
    
    //实现给一个反馈
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choice = tableTitle[indexPath.section]
        
        let name: String
        let titleOrstuno:String
        let age:Int
        if indexPath.section == 0 {
            name = teaArr[indexPath.row].fullName
            titleOrstuno = "职位:"+teaArr[indexPath.row].title
            age = teaArr[indexPath.row].age
        } else {
            name = stuArr[indexPath.row].fullName
            titleOrstuno = "学号:"+"\(stuArr[indexPath.row].stuNo)"
            age = stuArr[indexPath.row].age
        }
        
        let message =  "姓名: \(name)\n\(titleOrstuno)\n年龄:\(age)"
        
        let alert = UIAlertController(title: "\(choice)", message: message, preferredStyle: .alert)
        let OKBtn = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(OKBtn)
        self.present(alert, animated: true, completion: nil)
    }
   

}

