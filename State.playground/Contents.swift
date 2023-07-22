// State
// Initiated -> ReadyForPayment
// ReadyForPayment -> Pending
// ReadyForPayment -> Cancelled
// Pending -> Delivering
// Pending -> CancelledWithRefund
// Delivering -> Delivered
// Delivering -> CancelledWithRefund
// Delivered -> Finished
// Delivered -> Refunded

struct Order<T> {}

protocol Cancellable {}
protocol CancellableWithRefund {}
protocol Refundable {}

struct Initiated {}
struct ReadyForPayment: Cancellable {}
struct Pending: CancellableWithRefund {}
struct Delivering: CancellableWithRefund {}
struct Delivered: Refundable {}
struct Finished {}
struct Cancelled {}
struct CancelledWithRefund {}
struct Refunded {}

extension Order where T == Initiated {
    var readyForPayment: Order<ReadyForPayment> {
        Order<ReadyForPayment>()
    }
}

extension Order where T == ReadyForPayment {
    var pending: Order<Pending> {
        Order<Pending>()
    }
}

extension Order where T == Pending {
    var delivering: Order<Delivering> {
        Order<Delivering>()
    }
}

extension Order where T == Delivering {
    var delivered: Order<Delivered> {
        Order<Delivered>()
    }
}

extension Order where T == Delivered {
    var finished: Order<Finished> {
        Order<Finished>()
    }
}

extension Order where T: Cancellable {
    var canceled: Order<Cancelled> {
        Order<Cancelled>()
    }
}

extension Order where T: CancellableWithRefund {
    var canceledWithRefund: Order<CancelledWithRefund> {
        Order<CancelledWithRefund>()
    }
}

extension Order where T: Refundable {
    var refunded: Order<Refunded> {
        Order<Refunded>()
    }
}



let cancelled = Order<Initiated>().readyForPayment.canceled

let finished = Order<Initiated>().readyForPayment.pending.delivering.delivered

