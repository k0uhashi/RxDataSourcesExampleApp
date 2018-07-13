import RxSwift
import RxDataSources

struct SectionOfPerson {
    var header: String
    var items: [Item]
}

extension SectionOfPerson: SectionModelType {
    typealias Item = Person
    
    init(original: SectionOfPerson, items: [SectionOfPerson.Item]) {
        self = original
        self.items = items
    }
}

class CustomViewModel {
    
    let items = PublishSubject<[SectionOfPerson]>()
    
    func updateItem() {
        var sections: [SectionOfPerson] = []
        sections.append(SectionOfPerson(header: "section 1", items: [SectionOfPerson.Item(name: "Nozaki"), SectionOfPerson.Item(name: "Sakura")]))
        sections.append(SectionOfPerson(header: "section 2", items: [SectionOfPerson.Item(name: "Kashima"), SectionOfPerson.Item(name: "Hori")]))
        sections.append(SectionOfPerson(header: "section 3", items: [SectionOfPerson.Item(name: "Seo"), SectionOfPerson.Item(name: "Wakamatsu")]))
        items.onNext(sections)
    }
}
