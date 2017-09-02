//
//  ViewController.swift
//  CopingMindfulness
//
//  Created by 川守田敦史 1 on 2016/06/21.
//  Copyright © 2016年 Atsushi Kawamorita. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let DATA01: String = "背筋を伸ばして、両肩を結ぶ線がまっすぐになるように座り、目を閉じる。脚を組んでも、正座でも、椅子に座っても良いです。「背筋が伸びてその他の体の力は抜けている」楽な姿勢を見つけて下さい。"
    let DATA02: String = "呼吸をあるがままに感じる。呼吸をコントロールしないで、身体がそうしたいようにさせます。そして呼吸に伴ってお腹や胸がふくらんだり縮んだりする感覚に注意を向け、その感覚の変化を気づきが追いかけていくようにします。例えば、お腹や胸に感じる感覚が変化する様子を、心の中で、「ふくらみ、ふくらみ、縮み、縮み」などと実況すると感じやすくなります。"
    let DATA03: String = "わいてくる雑念や感情にとらわれない。単純な作業なので、「仕事のメールしなくちゃ」「ゴミ捨て忘れちゃった」など雑念が浮かんできます。そうしたら「雑念、雑念」と心の中でつぶやき、考えを切り上げ、「戻ります」と唱えて、呼吸に注意を戻します。「あいつには負けたくない」など考えてしまっている場合には、感情が動き始めています。「怒り、怒り」などと心の中でつぶやき、「戻ります」と唱えて、呼吸に注意を戻します。"
    let DATA04: String = "身体全体で呼吸するようにする。次に、注意のフォーカスを広げて、「今の瞬間」の現実を幅広く捉えるようにしていきます。最初は、身体全体で呼吸をするように、吸った息が手足の先まで流れ込んでいくように、吐く息が身体の隅々から流れ出ていくように感じながら、「ふくらみ、ふくらみ、縮み、縮み」と実況を続けていきます。"
    let DATA05: String = "身体の外にまで注意のフォーカスを広げていく。さらに、自分の周りの空間の隅々に気を配り、そこで気づくことのできる現実の全てを見守るようにしていきます。自分を取り巻く部屋の空気の動き、温度、広さなどを感じ、さらに外側の空間にも（部屋の外の音などに対しても）気を配っていきます。それと同時に「ふくらみ、ふくらみ、縮み、縮み」と実況は続けますが、そちらに向ける注意は弱くなり、何か雑念が出てきたことに気づいても、その辺りに漂わせておくようにして（「戻ります」とはせずに）、消えていくのを見届けます。"
    let DATA06: String = "瞑想を終了する。まぶたの裏に注意を向け、そっと目を開けていきます。伸びをしたり、身体をさすったりして、普段の自分に戻ります。"
    let LANGUAGE: String = "ja-JP"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func writeData(){
        var loopCounter: Int = 1
        for target in arrayData(){
            dataInsertMindfullness(loopCounter, data: target, language: LANGUAGE)
            loopCounter += 1
        }

        //dataInsertStressor(1)
    }
    
    func arrayData() -> Array<String> {
        let returnValue: Array<String> = [DATA01, DATA02, DATA03, DATA04, DATA05, DATA06]
        return returnValue
    }

    func dataInsertMindfullness(_ id: Int, data: String, language:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mindfulness = NSEntityDescription.insertNewObject(forEntityName: "MindfulnessContents", into: appDelegate.managedObjectContext) as! MindfulnessContents
        mindfulness.id = id as NSNumber?
        mindfulness.data = data
        mindfulness.language = language
        appDelegate.saveContext()
    }
    func dataInsertStressor(_ id: NSDecimalNumber){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let stressor = NSEntityDescription.insertNewObject(forEntityName: "StressorContents", into: appDelegate.managedObjectContext) as! StressorContents
        stressor.stressorId = id
        stressor.stressorData = "騒音" + String(describing: id)
    }
}

