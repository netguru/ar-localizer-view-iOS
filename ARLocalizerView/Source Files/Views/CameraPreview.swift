//
//  CameraPreview.swift
//  ARLocalizerView
//

import UIKit
import AVFoundation

final class CameraPreview: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let session = AVCaptureSession()

    func start() {
        setupPreviewLayer()
        setupVideoDataOutput()
        setupSession()
    }

    private func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspect
        previewLayer.frame = layer.bounds

        layer.masksToBounds = true
        layer.addSublayer(previewLayer)
    }

    private func setupVideoDataOutput() {
        let videoDataOutput = AVCaptureVideoDataOutput()
        let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")

        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        videoDataOutput.connection(with: .video)?.isEnabled = true

        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
        }
    }

    private func setupSession() {
        guard
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let deviceInput = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(deviceInput)
        else {
            return
        }

        session.addInput(deviceInput)
        session.sessionPreset = .hd1280x720
        session.startRunning()
    }
}
