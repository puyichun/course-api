Ruby  版本 3.1.2
Rails 版本 6.1.7

本專案有三個model，課程course、章節chapter、單元unit

course has_many chapters
chapter belongs_to course

chapter has_many units
unit belongs_to chapter


課程列表: (method: get)
https://pu-course-api.herokuapp.com/api/v1/courses

課程詳細資訊: (method: get)
https://pu-course-api.herokuapp.com/api/v1/courses/課程的id

建立課程: (method: post)
https://pu-course-api.herokuapp.com/api/v1/courses

JSON範例：

{ "course" : { "name": "課程名稱", "teacher": "講師名稱", "description": 課程說明" },
  "chapter": [{"name": "章節名稱1",
               "unit": [{ "name": "單元名稱1", "description": "單元說明", "content": "單元內容 (純文字的文章內容) "},
                        {" name": "第二單元", "description": "單元說明", "content": "單元內容"}]},
              {"name": "章節名稱2",
               "unit": [{"name": "第三單元", "description": "單元說明", "content": "單元內容"}]}]}]
}

編輯課程: (method: put/patch)
https://pu-course-api.herokuapp.com/api/v1/courses/課程的id

JSON範例：
{ "course" : {"name": "修改課程名稱", "teacher": "修改課程講師", "description": "修改課程描述" },
  "chapter": { "name": "修改章節名稱", "position": "修改章節順序(數字)", id: "章節id" },
  "unit": {"name": "修改單元名稱", "description": "修改單元描述" , "content": "修改單元內容" , "position": "修改單元順序(數字)", id: "單元id"}
}

刪除課程: (method: delete)
https://pu-course-api.herokuapp.com/api/v1/courses/課程的id


我使用到的第三方套件:

1.acts_as_list:

acts_as_list可以幫助我紀錄順序，依照position這個欄位進行排序。
當課程和章節建立起來時，他會依照建立順序給position數字（從1開始)
跟流水編號不同的是，當我建立了第二個課程，章節的position也是從1開始。
在update更改position時，例如我把第五章節的position從5更改成2，其他此課程的章節position也會跟其對應做改變。

2.factory_bot_rails:

factory_bot可以幫助我寫測試的時候幫助我快速的建立資料，少打一點code

在本專案我在使用一些第三方套件方法的時候會使用到註解。


當有多種實作方式時，請說明為什麼你會選擇此種方式？

我在本專案使用的方式也許不是最簡潔有力的，我選擇的是能夠安穩的把功能先寫出來的方式。

在本專案遇上的困難：

在部署Heroku的時候，出現了status 503的問題。
在網路上搜尋了老半天，我才發現自己看到的是最後問題的結果status 503，而不是問題本身。所以我這樣找根本不會有答案的。
heroku logs --tail 印出來的我只注意到最下面的 error status 503。
卻沒有注意到真正的問題寫在更上面: can not load such file: net/pop

最後我在Gemfile 加上

gem "net-pop", "~> 0.1.2"

gem "net-imap", "~> 0.3.1"

問題就解決了。