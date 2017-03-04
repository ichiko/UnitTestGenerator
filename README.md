# UnitTestGenerator
Xcode plugin that generate swift code unit test.

Before developers end up their activity, give a chance to acknowledge famous mistake.


This project was started from [try!Swift Hackathon](https://devpost.com/software/unit-test-assistant).

## How work it

[![](http://img.youtube.com/vi/z_tSMMcMRkQ&feature=youtu.be/0.jpg)](https://www.youtube.com/watch?v=z_tSMMcMRkQ&feature=youtu.be)

## What it does

Input
```
class Sparrow {
func fly(to_km: Int) {
}

func eat(energy: Meal) -> Bool {
// return true if enable eat
}
}
```

Output (Test code)
```
class SparrowTest {
func testFly() {}
func testFlyWithMaximam() {]
func testFlyWIthValueOutOfBounds() {}

func testEatWithMealInsect() {}
func testEatWithMealMeat() {}
}
```

## usecase

- create new file.
- write class and method definitions.
- select menu > edit > generate unit test.
- then, add new file if need.
- then, add method test template, that include test for covering famous mistake.

