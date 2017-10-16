//
//  FMDB.swift
//  Xcode
//
//  Created by Hanxun on 2017/10/13.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import FMDB

class FMDB: NSObject {
    
    
    let fileURL = try! FileManager.default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("MiningDB.sqlite")
    var miningDBQueue: FMDatabaseQueue = FMDatabaseQueue()
    

    static let shared = FMDB()
    class func getShared() -> FMDB {
        return shared
    }
    
    
    override init() {
        super.init()
        print("数据库路径: \(fileURL.path)")
        self.miningDBQueue = FMDatabaseQueue(path: fileURL.path)
        self.createDataBase()
        
        // 测试使用
//        self.insertSingleDataToWorkerInfoTable(data: nil)
    }
    
    
    /* 创建数据库 */
    private func createDataBase() {
        
        let sql = "CREATE TABLE IF NOT EXISTS WorkerInfoTable( "
            + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            + "MiningPool String, "
            + "WorkerGroup String, "
            + "WorkerId String, "
            + "CoinType String, "
            + "UserFlag Bool, "
            + "ActionFlag Integer "
            + ");"
        
        miningDBQueue.inDatabase({ (db) -> Void in
            if db.executeUpdate(sql, withArgumentsIn: []) == false {
                print("FMDB -- 打开数据库失败")
            }
        })
    }
    
    /* 增 */
    public func insertSingleDataToWorkerInfoTable(objectData: WorkerInfo) {
        
        let sql = "INSERT INTO WorkerInfoTable "
            + "(MiningPool, WorkerGroup, WorkerId, CoinType, UserFlag, ActionFlag)"
            + "VALUES (?, ?, ?, ?, ?, ?);"
        
        miningDBQueue.inTransaction({ (db, roolBack) -> Void in
            do {
                //try db.executeUpdate(sql, values: ["1", "12", "123", "1234", true, 2])
                try db.executeUpdate(sql, values: [objectData.MiningPool!,
                                                   objectData.WorkerGroup!,
                                                   objectData.WorkerId!,
                                                   objectData.CoinType!,
                                                   objectData.UserFlag!,
                                                   objectData.ActionFlag!] )
            } catch {
                roolBack.pointee = true
            }
        })
    }
    
    public func insertMultDataToWorkerInfoTable(arrayData: [WorkerInfo]) {
        
        arrayData.forEach({ (element) in
            DispatchQueue.global().async {
                self.insertSingleDataToWorkerInfoTable(objectData: element)
            }
        })
    }
    
    
    
    /* 删 */
    public func removeSingleDataFromWorkerInfoTable(objectData: WorkerInfo) {
        
        let sql = "DELETE FROM WorkerInfoTable WHERE MiningPool = \(objectData.MiningPool!)"
            + " AND WorkerGroup = \(objectData.WorkerGroup!)  AND WorkerId = \(objectData.WorkerId!)"
        
        miningDBQueue.inTransaction({ (db, roolback) -> Void in
            do {
                try db.executeUpdate(sql, values: [])
            } catch {
                roolback.pointee = true
            }
        })
    }
    
    public func removeMultDataFromWorkerInfoTable(arrayData: [WorkerInfo]) {
        arrayData.forEach({ (element) in
            DispatchQueue.global().async {
                self.removeSingleDataFromWorkerInfoTable(objectData: element)
            }
        })
    }
    
    public func removeWorkerInfoTable() {
        
        let sql = "DELETE FROM WorkerInfoTable"
        miningDBQueue.inTransaction({ (db, roolback) in
            do {
                try db.executeUpdate(sql, values: [])
            } catch {
                roolback.pointee = true
            }
        })
    }
    
    
    /* 改 */
    public func modifySingleDataFromWorkerInfoTableWithWorkerID(objectData: WorkerInfo) {
        /* 这里不仅仅要比较WorkerID了，还有网站和组也要 */
        let sql = "UPDATE WorkerInfoTable SET UserFlag = (?)  WHERE MiningPool = \(objectData.MiningPool!)"
            + " AND WorkerGroup = \(objectData.WorkerGroup!)  AND WorkerId = \(objectData.WorkerId!)"
        miningDBQueue.inTransaction({ (db, roolback) -> Void in
            do {
                try db.executeUpdate(sql, values: [objectData.UserFlag!])
            } catch {
                roolback.pointee = true
            }
        })
    }
    
    public func modifyMultDataFromWorkerInfoTable(arrayData: [WorkerInfo]) {
        arrayData.forEach({ (element) in
            DispatchQueue.global().async {
                self.modifySingleDataFromWorkerInfoTableWithWorkerID(objectData: element)
            }
        })
    }
    
    /* 查 */
    public func selectMultDataFromWorkerInfoTable(miningPool: String, group: String)  {
        
        let sql = "SELECT * FROM WorkerInfoTable WHERE MiningPool = \(miningPool)"
            + " AND WorkerGroup = \(group)"
        
        miningDBQueue.inTransaction({ (db, roolback) -> Void in
            do {
                let resultSet:FMResultSet? = try db.executeQuery(sql, values: nil)
                var arryBuff: [WorkerInfo] = [WorkerInfo]()
                while (resultSet?.next())! {
                    let objectBuff = WorkerInfo()
                    objectBuff.MiningPool = resultSet?.string(forColumn: "MiningPool")
                    objectBuff.WorkerGroup = resultSet?.string(forColumn: "WorkerGroup")
                    objectBuff.WorkerId = resultSet?.string(forColumn: "WorkerId")
                    objectBuff.CoinType = resultSet?.string(forColumn: "CoinType")
                    objectBuff.UserFlag = resultSet?.bool(forColumn: "UserFlag")
                    objectBuff.ActionFlag = Int((resultSet?.int(forColumn: "ActionFlag"))!)
                    arryBuff.append(objectBuff)
                }
            } catch {
                roolback.pointee = true
            }
        })
    }
}








