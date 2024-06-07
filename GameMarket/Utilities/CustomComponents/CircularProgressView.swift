//
//  CircularProgressView.swift
//  GameMarket
//
//  Created by Okan Orkun on 6.06.2024.
//

import UIKit

/// A view that displays a circular progress indicator.
final class CircularProgressView: UIView {
    /// The current progress, ranging from 0.0 to 5.0. Setting this property updates the view.
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
            updateProgressLabel()
            if !hasAnimated {
                animateProgress()
            } else {
                updateShapeLayerColor()
            }
        }
    }
    
    /// The label displaying the progress value.
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    /// The shape layer that represents the circular progress.
    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = circleLineWidth
        layer.lineCap = .round
        return layer
    }()
    
    /// Flag indicating whether the progress has been animated.
    private var hasAnimated = false
    
    /// Duration of the progress animation.
    private let animationDuration: CFTimeInterval = 3.0
    
    /// Line width of the circular progress indicator.
    private let circleLineWidth: CGFloat = 2.0

    /// Initializes the view with a frame.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressLabel()
        setupShapeLayer()
    }
    
    /// Initializes the view from a storyboard or nib file.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressLabel()
        setupShapeLayer()
    }
    
    /// Lays out subviews.
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLabel.frame = bounds
        shapeLayer.frame = bounds
    }
    
    /// Draws the view's contents.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawProgressCircle()
    }
    
    /// Sets up the progress label.
    private func setupProgressLabel() {
        addSubview(progressLabel)
        updateProgressLabel()
    }
    
    /// Updates the text of the progress label.
    private func updateProgressLabel() {
        progressLabel.text = String(format: "%.2f", progress)
    }
    
    /// Sets up the shape layer.
    private func setupShapeLayer() {
        layer.addSublayer(shapeLayer)
    }
    
    /// Draws the circular progress indicator.
    private func drawProgressCircle() {
        let halfSize = min(bounds.size.width / 2, bounds.size.height / 2)
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: halfSize, y: halfSize),
            radius: halfSize - (circleLineWidth / 2),
            startAngle: -0.5 * .pi,
            endAngle: 2 * .pi * (progress / 5.0) - 0.5 * .pi,
            clockwise: true)
        shapeLayer.path = circlePath.cgPath
    }
    
    /// Animates the progress change.
    private func animateProgress() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = progress / 5.0
        strokeAnimation.duration = animationDuration
        strokeAnimation.fillMode = .forwards
        strokeAnimation.isRemovedOnCompletion = false
        shapeLayer.add(strokeAnimation, forKey: "progressAnimation")
        
        let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
        colorAnimation.fromValue = UIColor.systemRed.cgColor
        colorAnimation.toValue = calculateColor(for: progress).cgColor
        colorAnimation.duration = animationDuration
        colorAnimation.fillMode = .forwards
        colorAnimation.isRemovedOnCompletion = false
        shapeLayer.add(colorAnimation, forKey: "colorAnimation")
        
        hasAnimated = true
    }
    
    /// Resets the progress to zero and removes animations.
    func resetProgress() {
        hasAnimated = false
        progress = 0.0
        shapeLayer.removeAllAnimations()
        shapeLayer.path = nil
    }
    
    /// Updates the color of the shape layer based on the current progress.
    private func updateShapeLayerColor() {
        let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
        colorAnimation.fromValue = shapeLayer.strokeColor
        colorAnimation.toValue = calculateColor(for: progress).cgColor
        colorAnimation.duration = 0.5
        colorAnimation.fillMode = .forwards
        colorAnimation.isRemovedOnCompletion = false
        shapeLayer.add(colorAnimation, forKey: "colorTransitionAnimation")
        
        shapeLayer.strokeColor = calculateColor(for: progress).cgColor
    }
    
    /// Calculates the color based on the current progress.
    /// - Parameter progress: The current progress.
    /// - Returns: The corresponding color.
    private func calculateColor(for progress: CGFloat) -> UIColor {
        switch progress {
        case 0:
            return .systemRed
        case 5:
            return .systemGreen
        default:
            let percentage = progress / 5.0
            if percentage <= 0.5 {
                return interpolate(from: .systemRed, to: .systemYellow, with: percentage * 2)
            } else {
                return interpolate(from: .systemYellow, to: .systemGreen, with: (percentage - 0.5) * 2)
            }
        }
    }
    
    /// Interpolates between two colors.
    /// - Parameters:
    ///   - color1: The start color.
    ///   - color2: The end color.
    ///   - percentage: The interpolation percentage.
    /// - Returns: The interpolated color.
    private func interpolate(from color1: UIColor, to color2: UIColor, with percentage: CGFloat) -> UIColor {
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(
            red: r1 + (r2 - r1) * percentage,
            green: g1 + (g2 - g1) * percentage,
            blue: b1 + (b2 - b1) * percentage,
            alpha: a1 + (a2 - a1) * percentage
        )
    }
}
