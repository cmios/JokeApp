//
//  JokePresenter.swift
//  DailyJoke
//
//  Created by CM on 28/06/23.
//

import Foundation


protocol JokeViewDelegates:NSObject{
    func DisplayNewJoke(joke:JokeModel)
    func DisplayError(strError:String)
}

class JokePresenter{
    
    weak private var jokeViewDelegate:JokeViewDelegates?
    private let apiCall:ApiServiceClass
    private var arrJokes = JokeModel(arrJokeMsg: [])
    
    //MARK: Dependency Injected using init
    
    init(apCall:ApiServiceClass) {
        self.apiCall = apCall
    }
    
    func JokeDelegetesSelf(jkSelf:JokeViewDelegates){
        self.jokeViewDelegate = jkSelf
    }
    
    //MARK: Get old saved joke from user default
    
    func GetOldJoke(){
        let enDt = GlobalApp().uDefault.value(forKey: "JOKE")
        let jsDec = JSONDecoder()
        let dt = try? jsDec.decode(JokeModel.self, from: enDt as? Data ?? Data())
        arrJokes = dt ?? JokeModel(arrJokeMsg: [])
        self.jokeViewDelegate?.DisplayNewJoke(joke: arrJokes)
    }
    
    //MARK: Get new  joke from Api service
    
    func GetNewJokes(){
        Task {

            do {
                
                let strJoke = try await apiCall.GetNewJokes()
                
                self.arrJokes.arrJokeMsg.append(strJoke)
                
                if self.arrJokes.arrJokeMsg.count>10{
                    self.arrJokes.arrJokeMsg.remove(at: 0)
                }
                
               //Save data in user default
                let jsEn = JSONEncoder()
                let dt = try? jsEn.encode(self.arrJokes)
                GlobalApp().uDefault.set(dt, forKey: "JOKE")
                
                self.jokeViewDelegate?.DisplayNewJoke(joke: self.arrJokes)
                
                
            } catch {
                
                print("Request failed with error: \(error)")
                self.jokeViewDelegate?.DisplayError(strError: error.localizedDescription)
            }

        }
       
            
       
    }
    
}
