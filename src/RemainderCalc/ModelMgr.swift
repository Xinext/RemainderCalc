//
//  ModelMgr.swift
//  RemainderCalc
//


import Foundation
import CoreData
import UIKit

/**
 モデルマネージャークラス
 */
class ModelMgr {

    // MARK: - Const of attribute name
    static public let CNS_M_I_ANSWER = "m_i_answer"
    static public let CNS_M_I_DECIMAL_POSITION = "m_i_decimal_position"
    static public let CNS_M_I_DIVIDEND = "m_i_dividend"
    static public let CNS_M_I_DIVISOR = "m_i_divisor"
    static public let CNS_M_I_EXPRESSION = "m_i_expression"
    static public let CNS_M_K_UPDATE_TIME = "m_k_update_time"
    
    // MARK: - Static function
    /**
     履歴データの保存
     - parameter setModel: (D_History)-> Void データセット用クロージャー
     */
    static func Save_D_History( setModel: ((D_History)-> Void) ) {
        
        // コンテキストの取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // モデルの作成
        let model = D_History(context:context)
        setModel(model) // クロージャー内でデータをセット

        // 保存
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    /**
     履歴データの読出し
     - parameter (AnyObject)-> Void データ取得用クロージャー
     */
    static func Load_D_History(getModels: ((D_History)-> Void)) {

        // コンテキストの取得
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        // クエリーの生成
        let request: NSFetchRequest<D_History> = D_History.fetchRequest()
        let sortDescripter = NSSortDescriptor(key: self.CNS_M_K_UPDATE_TIME, ascending: false)  // 日付の降順で取り出す
        request.sortDescriptors = [sortDescripter]
        
        // データの取得
        do {
            let fetchResults = try context.fetch(request) as Array<D_History>
            for result: D_History in fetchResults {
                
                getModels(result)   // クロージャー内でデータを取得
            }
        } catch {
            print(error)
        }
    }
    
    /**
     履歴データの読出し
     - returns: データ配列
     */
    static func Load_D_History() -> Array<D_History> {
        
        var resArray = Array<D_History>()
        
        // コンテキストの取得
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // クエリーの生成
        let request: NSFetchRequest<D_History> = D_History.fetchRequest()
        let sortDescripter = NSSortDescriptor(key: self.CNS_M_K_UPDATE_TIME, ascending: false)  // 日付の降順で取り出す
        request.sortDescriptors = [sortDescripter]
        
        
        // データの取得
        do {
            resArray = try context.fetch(request) as Array<D_History>
        } catch {
            resArray.removeAll()
            print(error)
        }
        
        return resArray
    }
    
    /**
     データ件数の取得
     - returns: データ件数
     */
    static func GetCount_D_History() -> Int {
        
        var result: Int = 0
        
        // コンテキストの取得
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // クエリーの生成
        let request: NSFetchRequest<D_History> = D_History.fetchRequest()
        
        // データ件数の取得
        do {
            let fetchResults = try context.fetch(request)
            result = fetchResults.count
        } catch {
            result = 0
        }
        
        return result
    }
    
}
