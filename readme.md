# Marathon Training Program - Novice Supreme

This Ruby script generates a 30-week marathon training program based on Hal Higdon's Novice Supreme marathon training schedule. The program includes various runs, walks, and cross-training sessions to gradually build up your endurance for completing a marathon.

## Features

- Follows the 30-week training schedule from [Hal Higdon's Novice Supreme Marathon Training](https://www.halhigdon.com/training-programs/marathon-training/novice-supreme/).
- Automatically calculates the start date (next Monday) and creates a detailed training plan.
- Outputs the training schedule in an `.ics` file, which can be imported into any calendar app.
- Supports custom event duration and generates descriptive event names for different activities (runs, walks, cross-training, etc.).

## Getting Started

### Prerequisites

Make sure you have Ruby installed on your system. You can check your version with:

```bash
ruby -v
```

If Ruby is not installed, follow the instructions [here](https://www.ruby-lang.org/en/documentation/installation/) to install it.

### Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/nicolasleander/Marathon-Training-Novice-Supreme.git
    cd Marathon-Training-Novice-Supreme
    ```

2. Run the script:

    ```bash
    ruby marathon_training_generator.rb
    ```

    This will create an `.ics` file with the full 30-week training plan starting from the next Monday.

3. Import the `marathon_training_program.ics` file into your calendar app to track your daily activities.

### Customization

- The script calculates the next Monday as the start date, but you can adjust this by modifying the `start_date` logic.
- You can also adjust the event duration or start time if needed by changing the `event_duration` variable in the script.

### Output

- The program outputs a detailed training schedule that includes rest days, runs, walks, cross-training, and the final marathon day.
- The `.ics` file can be used to schedule your training activities in a calendar.

## Reference

This script is based on the [Hal Higdon Novice Supreme Marathon Training Plan](https://www.halhigdon.com/training-programs/marathon-training/novice-supreme/).

## License

This project is licensed under the MIT License.
