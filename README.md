# Ruby Learning from the beginner level to the intermediate level

## Goal

- To be able to create console todo (CRUD) application using Ruby and JSON

## Environment

- macOS
- Ruby 3.3.4

## Learning Path

1. Install Ruby

```bash
ruby -v         # check ruby version
brew --version  # check brew version
rbenv -v        # check rbenv version, rbenv is like a nvm for Node.js
rbenv versions  # check rbenv versions

# Step 1: Install Ruby
I checked the current environment:

Operation System: macOS
Package Manager: Homebrew and rbenv are installed (Great!)
Ruby Version: Currently using system Ruby (2.6.10).
Ruby 3.3.4 is not installed.
Action Plan: We need to install Ruby 3.3.4 using rbenv.
This compilation process might take a few minutes.

rbenv install 3.3.4  # install Ruby 3.3.4
rbenv local 3.3.4 && ruby -v  # set local Ruby version
#rbenv global 3.3.4 && ruby -v  # set global Ruby version

cat .ruby-version # check Ruby version
eval "$(rbenv init -)" && ruby -v # check Ruby version
```

### 요약 비교표

| Node.js           | Ruby                 | 설명                                 |
| :---------------- | :------------------- | :----------------------------------- |
| **nvm**           | **rbenv** / RVM      | 언어 버전 관리 (여러 버전 설치/전환) |
| **npm** / yarn    | **Bundler** (Gem)    | 패키지(라이브러리) 의존성 관리       |
| **package.json**  | **Gemfile**          | 프로젝트 명세서 (의존성 목록)        |
| **node_modules/** | (시스템/vendor 폴더) | 설치된 라이브러리 저장소             |
| **node**          | **ruby**             | 소스 코드 실행기                     |

이제 루비 환경이 더 익숙하게 느껴지실 것 같네요! 😊

### Console Todo (CRUD) application using Ruby and JSON

```bash
ruby main.rb
```

#### Project Structure

```bash
consoleTodoWithJson/
├── main.rb                  # [진입점] 프로그램 시작, 샘플 실행 메뉴 제공
├── samples/                 # [샘플 코드들] 학습용 예제 파일 모음
│   ├── 02_basic.rb, 03_file_io.rb...
│   ├── 06_todo_app.rb       # [핵심] 실제 투두 앱 실행 로직 (View)
│   ├── lib/                 # [핵심] 투두 앱의 부품들
│   │   ├── todo_item.rb     # [모델] 데이터 그 자체 (ID, 제목, 완료여부)
│   │   ├── json_store.rb    # [저장소] JSON 파일 읽기/쓰기 담당
│   │   └── todo_manager.rb  # [매니저] 추가/삭제 등 로직 담당
│   └── utils/
│       └── Utils.rb         #공통 유틸리티 (로깅, 랜덤 아이콘 등)
└── data/
    └── todos.json           # [DB] 실제로 데이터가 저장되는 파일
```

#### 🧩 핵심 구성 요소

1. TodoItem

```ruby
class TodoItem
  attr_accessor :id, :title, :completed

  def initialize(id, title, completed)
    @id = id
    @title = title
    @completed = completed
  end
end
```

2. JsonStore (Model)

```ruby
class JsonStore
  def initialize(filename)
    @filename = filename
  end

  def load
    File.read(@filename)
  end

  def save(data)
    File.write(@filename, data)
  end
end
```

3. TodoManager (Controller/Service)

```ruby
class TodoManager
  def initialize
    @todos = []
  end

  def add_todo(todo)
    @todos << todo
  end

  def remove_todo(todo)
    @todos.delete(todo)
  end
end
```

4. TodoApp (View/UI)

```ruby
class TodoApp
  def initialize
    @store = JsonStore.new('todo_data.json')
    @manager = TodoManager.new
  end
end
```

#### 🚀 실행 흐름

1. 💎 ruby main.rb 실행
2. 사용자가 6. Todo App 선택
3. 💎 TodoApp 실행 → 💎 TodoManager부름 → 💎 JsonStore파일 로딩
4. 사용자가 "할 일 추가" 입력
5. TodoManager TodoItem 생성 → JsonStore 파일에 저장
6. 💎 프로그램을 꺼도 data/todos.json에 내용이 남아있음!

#### 🛡️ Sorbet 타입 시스템 도입 계획

루비 프로젝트에 Sorbet을 적용하여 타입 안전성을 높이겠습니다.

📋 진행 순서
의존성 설치: Gemfile을 만들고 sorbet-runtime 라이브러리를 설치합니다.
타입 정의 적용:
TodoItem: 속성(String, Boolean)과 메서드 입출력 타입 정의
JsonStore: 파일 입출력 데이터 구조(Hash 배열) 타입 정의
TodoManager: 괸리 로직의 파라미터(index 등) 타입 정의

```bash
# Gemfile에 정의된 의존성 설치
$ bundle install

# sorbet 추가 in Gemfile, Gemfile.lock에 추가
# --group development 옵션을 줘서 개발용 그룹에 추가합니다.
$ bundle add sorbet --group "development"

# sorbet-runtime 추가 in Gemfile, Gemfile.lock에 추가
$ bundle add sorbet-runtime

# Sorbet이 프로젝트를 스캔하고 초기 설정 파일(sorbet/config) 생성
$ bundle exec srb init

# 타입 체크
$ bundle exec srb tc
# No errors! Great job.

# main.rb 실행
$ bundle exec ruby main.rb
```

```bash
$ srb init
```
