# DateKit
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FDateKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/NikSativa/DateKit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FDateKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/NikSativa/DateKit)

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
