import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes: [String: Int] = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    
    var countDownTimer: Timer?
    var totalTime = 60;
    var timeRemaining = 60;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "How do you like your eggs?"
        progressBar.setProgress(1.0, animated: true) // start full
    }
    
    

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        
        if let minutes = eggTimes[hardness] {
            totalTime = minutes * 60
            timeRemaining = totalTime
            starttimer()
        } else {
            print("Not a hardness")
        }
    }
    
    func starttimer() {
        countDownTimer?.invalidate()
        // progressBar.setProgress(1.0, animated: true) // start full
        countDownTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func updateTime() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            let _ = timeFormatted(timeRemaining)
            
            let percentage = Float(timeRemaining) / Float(totalTime)
            progressBar.setProgress(percentage, animated: true)
        }else {
            endTimer()
        }
    }
    
    func endTimer() {
        countDownTimer?.invalidate()
        statusLabel.text = "Done!"
        // print("Timer Finished")
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let minites = totalSeconds / 60
        let seconds = totalSeconds % 60
        let formattedTime = String(format: "%02d:%02d", minites, seconds)
        // print(formattedTime)
        return formattedTime
    }
}

