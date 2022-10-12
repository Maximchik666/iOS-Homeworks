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
    public var image: UIImage?
    public var likes: Int
    public var views: Int
    
}

 var post1 = Post(author: "DTF", description: "Илон Маск в серии коротких твитов раскритиковал «Кольца власти», написав, что «Толкин переворачивается в своём гробу». Миллиардер назвал почти всех героев мужского пола «трусами и придурками», а Галадриэль, по его мнению, единственный интересный персонаж сериала.", image:UIImage(named: "IMG-1"), likes: 350, views: 1000)
 var post2 = Post(author: "KinoPoisk", description: "Вышедший в 2021 году на Netflix мультсериал «Аркейн» стал первым стриминг-проектом, получившим премию «Эмми» в категории «Лучшая анимационная программа» на Creative Arts Emmy Awards.Проект от Netflix оставил позади «Симпсонов», «Рика и Морти», «Закусочную Боба» и мультсериал от Marvel «Что, если..?». Последний не остался без наград: «Эмми» за лучшее закадровое озвучание персонажа посмертно получил Чедвик Боузман, подаривший свой голос Т’Чалле.Премию вручают за технические достижения на американском телевидении. Основная церемония награждения «Эмми» пройдет 13 сентября.", image: UIImage(named: "IMG-2"), likes: 450, views: 1300)
 var post3 = Post(author: "Кроненберг Нефильтрованный", description: "Хоррор дня: как сейчас выглядит одна из аниматронных кукол инопланетянина из знаменитого фильма Стивена Спилберга. «Инопланетянину» в этом году исполнилось 40 лет.", image: UIImage(named: "IMG-3"), likes: 300, views: 700)

public var viewModel = [post1, post2, post3]

