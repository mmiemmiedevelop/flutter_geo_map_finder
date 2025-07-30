### 🛠 사용 라이브러리

- **Riverpod**  
  상태관리 라이브러리 (MVVM의 ViewModel 역할)  
  *Provider*를 활용하여 View(Widget)와 Model(Data) 연결

- **추가 라이브러리**  
  : `NAVER Open API`, `Firestore`, `dio`


### 🛠 폴더 구조

<pre>
lib/
 ├── models/          # 데이터 모델(주소, 리뷰)
 ├── networks/        # API 연동, 통신 코드 (네이버, Firestore)
 ├── screens/         # UI 화면별 위젯
 ├── view_model/      # 상태관리 및 비즈니스 로직 (Riverpod 기반, MVVM의 ViewModel 역할)
 └── main.dart        # 진입점
</pre>

