//
//  Struct Post.swift
//  Navigation
//
//  Created by Maksim Kruglov on 17.08.2022.
//

import Foundation
import UIKit

public struct Post {
    
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
}

 var post1 = Post(author: "DTF", description: "Илон Маск в серии коротких твитов раскритиковал «Кольца власти», написав, что «Толкин переворачивается в своём гробу». Миллиардер назвал почти всех героев мужского пола «трусами и придурками», а Галадриэль, по его мнению, единственный интересный персонаж сериала.", image: "IMG-1", likes: 350, views: 1000)
 var post2 = Post(author: "KinoPoisk", description: "Вышедший в 2021 году на Netflix мультсериал «Аркейн» стал первым стриминг-проектом, получившим премию «Эмми» в категории «Лучшая анимационная программа» на Creative Arts Emmy Awards.Проект от Netflix оставил позади «Симпсонов», «Рика и Морти», «Закусочную Боба» и мультсериал от Marvel «Что, если..?». Последний не остался без наград: «Эмми» за лучшее закадровое озвучание персонажа посмертно получил Чедвик Боузман, подаривший свой голос Т’Чалле.Премию вручают за технические достижения на американском телевидении. Основная церемония награждения «Эмми» пройдет 13 сентября.", image: "IMG-2", likes: 450, views: 1300)
 var post3 = Post(author: "Кроненберг Нефильтрованный", description: "Хоррор дня: как сейчас выглядит одна из аниматронных кукол инопланетянина из знаменитого фильма Стивена Спилберга. «Инопланетянину» в этом году исполнилось 40 лет.", image: "IMG-3", likes: 300, views: 700)

public var viewModel = [post1, post2, post3]

public var photoContainer = [UIImage(named:"IMG-5")!, UIImage(named:"IMG-6")!, UIImage(named:"IMG-7")!, UIImage(named:"IMG-8")!, UIImage(named:"IMG-9")!, UIImage(named:"IMG-10")!, UIImage(named:"IMG-11")!, UIImage(named:"IMG-12")!, UIImage(named:"IMG-13")!, UIImage(named:"IMG-14")!, UIImage(named:"IMG-15")!, UIImage(named:"IMG-16")!, UIImage(named:"IMG-17")!, UIImage(named:"IMG-18")!, UIImage(named:"IMG-19")!, UIImage(named:"IMG-20")!, UIImage(named:"IMG-21")!, UIImage(named:"IMG-22")!, UIImage(named:"IMG-23")!, UIImage(named:"IMG-24")!, UIImage(named:"IMG-25")!, UIImage(named:"IMG-26")!, UIImage(named:"IMG-27")!]

