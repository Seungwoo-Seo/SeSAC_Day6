//
//  LEDBoardViewController.swift
//  SeSAC_Day6
//
//  Created by 서승우 on 2023/07/24.
//

import UIKit

final class LEDBoardViewController: UIViewController {

    @IBOutlet weak var boardTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var boardLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesBegan(touches, with: event)

        endEditingKeyboard()
        isHiddenToggleBoardTextFieldArea()
    }

    // sendButton Tap 했을 때
    @IBAction func didTapSendButton(_ sender: UIButton) {
        guard let text = boardTextField.text
        else {
            presentAlert(
                title: "boardTextField의 text 값이 nil입니다."
            )
            return
        }

        sendTextToBoardLabel(text)
    }

    // colorButton Tap 했을 때
    @IBAction func didTapColorButton(_ sender: UIButton) {
        randomlyChangeTextColor()
    }

}

extension LEDBoardViewController: UITextFieldDelegate {

    // keyboard의 returnButton Tap 했을 때
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        endEditingKeyboard()

        return true
    }

}

// 뷰 구성
private extension LEDBoardViewController {

    func configureBoardTextField() {
        boardTextField.placeholder = "내용을 작성해주세요."
        boardTextField.delegate = self
    }

    func configureHierarchy() {
        configureBoardTextField()
    }

}

// 뷰 동작
private extension LEDBoardViewController {

    // 키보드 내리기
    func endEditingKeyboard() {
        // 터치 이벤트가 시작되면
        // 루트 뷰에 하위에 있는 모든 뷰의 편집을 끝낸다.
        // 텍스트 필드나 버튼은 isUserInteractionEnabled 속성이 true이기
        // 때문에 view의 터치 이벤트가 발생해도 무시하게 된다.
        view.endEditing(true)
    }

    // boardTextField의 영역에 있는 뷰들의 히든을 toggle하기
    func isHiddenToggleBoardTextFieldArea() {
        boardTextField.isHidden = !boardTextField.isHidden
        sendButton.isHidden = !sendButton.isHidden
        colorButton.isHidden = !colorButton.isHidden
    }

    // 알럿 만들고 띄우기
    func presentAlert(title: String) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )

        let confirm = UIAlertAction(
            title: "확인",
            style: .cancel
        )

        alert.addAction(confirm)

        present(alert, animated: true)
    }

}

// 비즈니스 로직?
private extension LEDBoardViewController {

    // boardLabel에 텍스트를 보내줌
    func sendTextToBoardLabel(_ text: String) {
        // 공백 제거
        // 공백이 있으면 isEmpty 속성이 false가 되기 떄문
        let text = text.trimmingCharacters(in: .whitespaces)

        if text.isEmpty {
            presentAlert(title: "보낼 텍스트를 입력하세요.")
        } else {
            boardLabel.text = text
        }
    }

    // 랜덤으로 텍스트 색상을 변경해줌
    func randomlyChangeTextColor() {
        let r = CGFloat.random(in: 0...255)/255
        let g = CGFloat.random(in: 0...255)/255
        let b = CGFloat.random(in: 0...255)/255
        let randomColor = UIColor(
            red: r,
            green: g,
            blue: b,
            alpha: 1
        )

        boardLabel.textColor = randomColor
        boardTextField.tintColor = randomColor
        colorButton.configuration?.baseForegroundColor = randomColor
    }

}
