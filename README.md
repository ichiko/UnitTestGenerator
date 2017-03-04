# UnitTestGenerator
Xcode plugin that generate swift code unit test.

Before developers end up their activity, give a chance to acknowledge famous mistake.


This project was started from [try!Swift Hackathon](https://devpost.com/software/unit-test-assistant).

## How work it

<iframe width="560" height="315" src="https://www.youtube.com/embed/z_tSMMcMRkQ" frameborder="0" allowfullscreen></iframe>

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

