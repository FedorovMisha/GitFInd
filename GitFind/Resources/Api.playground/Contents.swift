import UIKit
import RxSwift

let single = SearchService().search(request: SearchRequestModel(query: "treelllo", resultCount: 25, page: 1))

single.subscribe(onSuccess:{
    print($0.items)
})
