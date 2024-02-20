//
//  ViewController.swift
//  randomPhoto
//
//  Created by Feihuan Peng on 2/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        //create a image widget
        let imageView = UIImageView()
        // make image fill the widget
        imageView.contentMode = .scaleAspectFill
        // set background to white
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    private let button: UIButton = {
        //declare a ui button
        let button = UIButton()
        //set bg color
        button.backgroundColor = .white
        // set title
        button.setTitle("Random Photo", for: .normal)
        //set text color
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let colors: [UIColor] = [
        UIColor.systemPink,
        UIColor.systemBlue,
        UIColor.systemRed,
        UIColor.systemOrange,
        UIColor.systemYellow,
        UIColor.systemTeal,
        UIColor.systemCyan,
        UIColor.systemMint
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // change background color to system pink
        view.backgroundColor = .systemPink
        
        // add imageView to view
        view.addSubview(imageView)
        
        //defind the position and size
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300 )
        //this is understandable lol
        imageView.center = view.center
        
        //call the get randomImage function
        getRandomPhoto()
        
        // add event listener
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    // @obj has to be added in a button func
    @objc func didTapButton(){
        getRandomPhoto()
        // get a random element in a array
        view.backgroundColor = colors.randomElement()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(button)
        
        //set size and positiob
        button.frame = CGRect(x: 30,
                              y: view.frame.size.height-150-view.safeAreaInsets.bottom,
                              width: view.frame.size.width-60,
                              height: 55)
        
    }
    
    func getRandomPhoto() {
        // The URL of the random photo to fetch
        let urlString = "https://source.unsplash.com/random/600x600"
        
        // Create a URL object from the string URL
        guard let url = URL(string: urlString) else {
            // If the URL cannot be created, return early
            return
        }
        
        // Create a URLSession data task to asynchronously fetch data from the URL
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            // Closure that executes when the data task completes
            
            // Ensure that data is not nil and there are no errors
            guard let data = data, error == nil else {
                // Print an error message if data fetching fails
                print("Error fetching random photo:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                // Set the fetched image data to the imageView's image property
                self?.imageView.image = UIImage(data: data)
            }
        }
        
        // Resume the URLSession data task to initiate the data fetching process
        task.resume()
    }

}


