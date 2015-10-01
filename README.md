# AIRTimer

Restartable NSTimer in Swift.

## Usage

```swift
// After 5 seconds
let timer = AIRTimer.after(5, userInfo: "FIRE!!") { timer in
  print(timer.userInfo!)
}

// Every 5 seconds
let timer = AIRTimer.every(5, userInfo: "FIRE!!") { timer in
  print(timer.userInfo!)
}

// Invalidate
timer.invalidate()

// Restart: Returns a regenerated instance
timer = timer.restart()
```

## Requirements
* iOS8.0+
* Xcode7.0+

## Installation
### CococaPods

```ruby
pod 'AIRTimer'
```

### Carthage
```
github "recruit-lifestyle/AIRTimer"
```

## Credit
AIRTimer is owned by maintained by RECRUIT LIFESTYLE CO., LTD.

AIRTimer was originally created by [Yuki Nagai](https://github.com/uny).

## License
```
Copyright 2015 RECRUIT LIFESTYLE CO., LTD.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
