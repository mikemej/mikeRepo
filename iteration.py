#iteracting over list

def count_odd(numbers):
    count = 0
    for num in numbers:
        if num % 2 == 1:
            count += 1
    return count

def check_odd(numbers):
    for num in numbers:
        if num % 2 == 1:
            return True
    return False


def remove_odd(numbers):
    no_odd_list = []
    for num in numbers:
        if num % 2 == 0:
            no_odd_list.append(num)
    return no_odd_list


def run():
    numbers = [1,7,2,34,8,7,2,5,14,22,93,48,76,15,7]
    print numbers
    print count_odd(numbers)
    print check_odd(numbers)
    print remove_odd(numbers)
run()
