//
//  TempData.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/19.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

struct TempData {
    static let categories = [
        Category(id: 1, budget: 500000),
        Category(id: 2, budget: 200000),
        Category(id: 3, budget: 150000),
        Category(id: 4, budget: 100000),
        Category(id: 5, budget: 50000),
        Category(id: 6, budget: 50000),
        Category(id: 7, budget: 70000)
    ]
    static let expenditure = [
        Expenditure(id: 1, desc: "친구들과 만남", cost: 12000, date: "2019-11-01 22:35"),
        Expenditure(id: 1, desc: "아점 해장", cost: 8000, date: "2019-11-02 14:22"),
        Expenditure(id: 2, desc: "청바지 구입", cost: 30000, date: "2019-11-02 17:25"),
        Expenditure(id: 5, desc: "영화 관람", cost: 12000, date: "2019-11-03 13:10"),
        Expenditure(id: 1, desc: "스시 오마카세", cost: 20000, date: "2019-11-03 19:11"),
        Expenditure(id: 1, desc: "순대국밥", cost: 7000, date: "2019-11-04 20:55"),
        Expenditure(id: 1, desc: "족발 야식", cost: 15000, date: "2019-11-05 23:07"),
        Expenditure(id: 4, desc: "지하철 정기권 결제", cost: 90000, date: "2019-11-06 18:12"),
        Expenditure(id: 3, desc: "영양제 구입", cost: 20000, date: "2019-11-07 17:12"),
        Expenditure(id: 1, desc: "뼈해장국", cost: 11000, date: "2019-11-07 20:32"),
        Expenditure(id: 1, desc: "동창들과 송년회", cost: 25000, date: "2019-11-08 20:45"),
        Expenditure(id: 6, desc: "친구 결혼식 축의금", cost: 100000, date: "2019-11-09 11:40"),
        Expenditure(id: 1, desc: "맥주 모임", cost: 10000, date: "2019-11-09 19:11"),
        Expenditure(id: 7, desc: "야옹이 간식", cost: 20000, date: "2019-11-10 12:51"),
        Expenditure(id: 1, desc: "이마트 장보기", cost: 30000, date: "2019-11-10 15:24"),
        Expenditure(id: 7, desc: "적금 자동이체", cost: 100000, date: "2019-11-11 07:41"),
        Expenditure(id: 1, desc: "아침 토스트", cost: 3000, date: "2019-11-11 08:30"),
        Expenditure(id: 1, desc: "점심 커피내기", cost: 30000, date: "2019-11-11 12:37"),
        Expenditure(id: 3, desc: "헤어컷", cost: 22000, date: "2019-11-11 19:19"),
        Expenditure(id: 1, desc: "퇴근길 맥주", cost: 20000, date: "2019-11-13 20:11"),
        Expenditure(id: 2, desc: "향수 구입", cost: 25000, date: "2019-11-14 19:01"),
        Expenditure(id: 1, desc: "버거킹 와퍼 세트", cost: 12000, date: "2019-11-15 20:14"),
        Expenditure(id: 1, desc: "점심 중식", cost: 10000, date: "2019-11-16 12:51"),
        Expenditure(id: 5, desc: "방탈출 게임", cost: 10000, date: "2019-11-16 17:43"),
        Expenditure(id: 1, desc: "배민 배달음식", cost: 15000, date: "2019-11-17 14:16"),
        Expenditure(id: 2, desc: "안경 구입", cost: 10000, date: "2019-11-19 20:36"),
        Expenditure(id: 1, desc: "보쌈 야식", cost: 15000, date: "2019-11-20 23:19"),
        Expenditure(id: 1, desc: "저녁 분식", cost: 10000, date: "2019-11-21 19:49"),
        Expenditure(id: 1, desc: "퇴근길 맥주", cost: 15000, date: "2019-11-22 20:34"),
        Expenditure(id: 1, desc: "홈플러스 장보기", cost: 50000, date: "2019-11-23 12:56"),
        Expenditure(id: 5, desc: "뮤지컬 관람", cost: 25000, date: "2019-11-24 15:12"),
        Expenditure(id: 2, desc: "휴대폰 악세사리 구입", cost: 30000, date: "2019-11-25 20:59"),
        Expenditure(id: 1, desc: "아이스 아메리카노", cost: 8000, date: "2019-11-26 12:59"),
        Expenditure(id: 1, desc: "편의점 도시락", cost: 6000, date: "2019-11-28 20:13"),
        Expenditure(id: 1, desc: "동창 모임 송년회", cost: 5000, date: "2019-11-29 18:00"),
    ]
    
    static let monthHistory = [
        1: MonthHistory(budget: 500000, mount: 400000),
        2: MonthHistory(budget: 1000000, mount: 700000),
        3: MonthHistory(budget: 700000, mount: 800000),
        4: MonthHistory(budget: 800000, mount: 1000000),
        5: MonthHistory(budget: 1200000, mount: 1100000),
        6: MonthHistory(budget: 1100000, mount: 1000000),
        7: MonthHistory(budget: 400000, mount: 800000),
        8: MonthHistory(budget: 900000, mount: 2000000),
        9: MonthHistory(budget: 1500000, mount: 1000000),
        10: MonthHistory(budget: 2000000, mount: 1700000)
    ]
    
    static func totalMonthHistory() -> [Int : MonthHistory] {
        let budget = TempData.categories.reduce(into: 0, { $0 += $1.budget })
        let mount = TempData.expenditure.reduce(into: 0, { $0 += $1.cost })
        
        var history = TempData.monthHistory
        history[11] = MonthHistory(budget: budget, mount: mount)
        
        return history
    }
}
