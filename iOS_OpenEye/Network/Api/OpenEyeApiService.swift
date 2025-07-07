//
//  OpenEyeApiService.swift
//  iOS_OpenEye
//  接口服务
//  Created by WinWang on 2025/6/3.
//

import Moya
import Combine

class OpenEyeApiService: APIServiceType {
    typealias Target = OpenEyeApi
    
    // 创建带有日志插件的接口请求Provider
    let provider = MoyaProvider<OpenEyeApi>(plugins: moyaPlugins)
    
    //获取首页
    func getHomeList(data: String)->AnyPublisher<HomeModel,APIError> {
        return requestPublisher(.home(data: data))
    }
    
    //获取关注列表
    func getFocusList(pageIndex:Int)->AnyPublisher<FocusModel,APIError>{
        return requestPublisher(.focus(pageIndex: pageIndex))
    }
    
    //获取分类数据
    func getCategoryList()->AnyPublisher<CategoryModel,APIError>{
        return requestPublisher(.category)
    }
    
    //获取topic列表
    func getTopicList(pageIndex:Int)->AnyPublisher<TopicModel,APIError>{
        return requestPublisher(.topic(pageIndex: pageIndex))
    }
    
    //获取排行榜列表
    func getRankList(rankType:String) ->AnyPublisher<HomeModel,APIError>{
        return requestPublisher(.rank(rankType: rankType))
    }
    
    //获取关联视频接口
    func getRelationInfo(id:Int)->AnyPublisher<HomeModel,APIError>{
        return requestPublisher(.relation(id: id))
    }
    
    //获取分类详情列表接口
    func getCategoryDetailList(id:Int,pageIndex:Int)->AnyPublisher<HomeModel,APIError>{
        return requestPublisher(.categoryDetail(id: id, pageIndex: pageIndex))
    }
}
