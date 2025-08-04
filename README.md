
# ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white) Geo Map Finder App by Flutter

**Flutter**를 학습하기 위한 지역 검색 앱입니다.

---

## 🚀 주요 기능
- **1. 네이버 검색 Open API 를 이용하여 지역 검색 기능을 구현**
- **2. Firebase Firestore를 이용하여 해당 지역 리뷰 저장하고 불러오기**

### 🛠 사용 라이브러리

- **Riverpod**  
  상태관리 라이브러리 (MVVM의 ViewModel 역할)  
  *Provider*를 활용하여 View(Widget)와 Model(Data) 연결

- **추가 라이브러리**  
  : `NAVER Open API`, `Firestore`, `dio`


### 📂 폴더 구조

<pre>
lib/
 ├── models/          # 데이터 모델(주소, 리뷰)
 ├── networks/        # API 연동, 통신 코드 (네이버, Firestore)
 ├── screens/         # UI 화면별 위젯
 ├── view_model/      # 상태관리 및 비즈니스 로직 (Riverpod 기반, MVVM의 ViewModel 역할)
 └── main.dart        # 진입점
</pre>


## ⚙️ 실행 예시
<p align="center">
  <img src="docs/1.png" width="100"/>
  <img src="docs/2.png" width="100"/>
  <img src="docs/3.png" width="100"/>
  <img src="docs/4.png" width="100"/>
</p>