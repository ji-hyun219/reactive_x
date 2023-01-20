# reactive_x
Flutter Reactive Programming


&nbsp;

<img width="589" alt="스크린샷 2023-01-20 오후 9 39 54" src="https://user-images.githubusercontent.com/91349474/213697055-b12dfd4d-9f79-4790-bb6d-70f7e4a44952.png">


위의 이미지를 보면 흐름을 실감할 수 있습니다. Widget은 Sink를 통해 BloC 클래스로 데이터/이벤트를 전송하고 Stream에서 알림을 받습니다.   

Widget에 비즈니스 로직가 없다는 것은 BloC에서 일어난 일이 UI의 책임이 아니라는 것을 의미합니다.   
  
이 아키텍처를 통해 비즈니스 로직 테스트 케이스들을 더 쉽게 테스트할 수 있도록 합니다. 왜냐하면 비즈니스 로직은 BloC class 에만 존재하기 때문입니다.   

