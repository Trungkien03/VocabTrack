//
//  AppReviewManager.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import Foundation

import Foundation
import StoreKit
import UIKit

class AppReviewManager {
    private let reviewInterval: TimeInterval = 60 * 60 * 24 * 3 // 7 ngày tính bằng giây
    private let lastReviewRequestKey = "lastReviewRequestDate"
    private let firstLaunchDateKey = "firstLaunchDate"
    private let daysUntilPrompt = 7 // Số ngày cần thiết trước khi yêu cầu đánh giá đầu tiên

    static let shared = AppReviewManager()

    private init() {
        // Nếu là lần đầu tiên khởi động ứng dụng, lưu lại ngày đầu tiên mở ứng dụng
        if UserDefaults.standard.object(forKey: firstLaunchDateKey) == nil {
            UserDefaults.standard.set(Date(), forKey: firstLaunchDateKey)
        }
    }

    /// Hàm kiểm tra và yêu cầu đánh giá nếu thích hợp
    func requestReviewIfAppropriate() {
        let currentDate = Date()

        // Lấy ngày lần đầu mở ứng dụng
        guard let firstLaunchDate = UserDefaults.standard.object(forKey: firstLaunchDateKey) as? Date else { return }

        // Tính số ngày từ khi người dùng mở ứng dụng lần đầu
        let daysSinceFirstLaunch = Calendar.current.dateComponents([.day], from: firstLaunchDate, to: currentDate).day ?? 0
        if daysSinceFirstLaunch < daysUntilPrompt {
            // Chưa đủ số ngày yêu cầu, dừng lại
            return
        }

        // Lấy ngày yêu cầu đánh giá lần cuối
        let lastReviewRequestDate = UserDefaults.standard.object(forKey: lastReviewRequestKey) as? Date

        // Kiểm tra xem đã đủ thời gian kể từ lần yêu cầu cuối cùng chưa
        if let lastDate = lastReviewRequestDate, currentDate.timeIntervalSince(lastDate) < reviewInterval {
            // Chưa đủ thời gian kể từ lần yêu cầu trước, dừng lại
            return
        }

        // Cập nhật ngày yêu cầu đánh giá lần cuối
        UserDefaults.standard.set(currentDate, forKey: lastReviewRequestKey)

        // Thực hiện yêu cầu đánh giá
        requestAppReview()
    }

    /// Hàm yêu cầu đánh giá trực tiếp thông qua `SKStoreReviewController`
    private func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
