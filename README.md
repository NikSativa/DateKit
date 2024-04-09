# DateKit

Swift library that provides a set of useful Date formatters.  
There is no longer any need to remember what is different "mm", "MM", "MMM" or "MMMM".

```swift
let format: String = "dd MMMM yyyy"
or
let format: DateFormat = [.dayOfMonth2Digits, .t(" "), .monthFull, .t(" "), .year4Digits]

// ------------------------------

let format: String = "MMM dd, EEE"
or
let format: DateFormat = [.monthShort, .t(" "), .dayOfMonth2Digits, .t(", "), .dayOfTheWeekShort]

```
