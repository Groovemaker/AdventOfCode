### Submarine Command Parser
### (c) 2021 - Runic
### Purpose: What the sub doin? | https://adventofcode.com/

### Main

### Declare Vars
fileName = "./input.txt"
arr = []
horizontal = 0
vertical = 0

## Open FileName
InputFile = File.open(fileName)

## Read each line into an array
arr = InputFile.each_line {|line|
    # Parse Submarine Commands and its args
    if line[0..6] == "forward"
        command = line[0..6]
        arg = line[8..-1]
        print "Command: <" + command + "> | Argument: "
        print arg + "\n"
        horizontal += arg.to_i
    end
    if line[0..3] == "back"
        command = line[0..3]
        arg = line[5..-1]
        print "Command: <" + command + "> | Argument: "
        print arg + "\n"
        horizontal -= arg.to_i
    end
    if line[0..3] == "down"
        command = line[0..3]
        arg = line[5..-1]
        print "Command: <" + command + "> | Argument: "
        print arg + "\n"
        vertical += arg.to_i
    end
    if line[0..1] == "up"
        command = line[0..1]
        arg = line[3..-1]
        print "Command: <" + command + "> | Argument: "
        print arg + "\n"
        vertical -= arg.to_i
    end
}

## Done. Print.
print "Submarine Course:\n"
print "X: " + horizontal.to_s + "\n"
print "Y: " + vertical.to_s + "\n"
print "Answer: " + horizontal.to_s + " * " + vertical.to_s + " = " + (horizontal * vertical).to_s + "\n"