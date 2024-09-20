import Foundation

extension Date {

    func transformDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM HH:mm"
        let firstPart = getFirstPart()
        dateFormatter.dateFormat = firstPart.isEmpty ? "d MMMHH:mm" : "HH:mm"
        return firstPart + dateFormatter.string(from: self)
    }

    private func getFirstPart() -> String {
        if Calendar.current.isDateInToday(self) {
            return "Today "
        }
        if Calendar.current.isDateInYesterday(self) {
            return "Yesterday "
        }
        return ""
    }

}
