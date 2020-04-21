import Foundation

extension DateFormatter {
    private func setTimeZoneAndDateFormat(format: String) {
        timeZone = NSTimeZone.local
        dateFormat = format
    }

    func mmmmDDyyyyString(from date: Date?) -> String? {
        guard let d = date else { return nil }
        setTimeZoneAndDateFormat(format: "MMMM dd, yyyy")
        return string(from: d)
    }

    func yyyyMMddDate(from dateString: String?) -> Date? {
        guard let string = dateString else { return nil }
        timeZone = TimeZone(identifier: "UTC")
        dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return date(from: string)
    }

    func covertFormatFromYyyyMMddToMMMMddyyyy(_ dateString: String?) -> String? {
        guard let date = yyyyMMddDate(from: dateString),
            let string = mmmmDDyyyyString(from: date) else {
            return nil
        }
        return string
    }
}
