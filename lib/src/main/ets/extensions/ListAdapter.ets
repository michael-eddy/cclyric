import ArrayList from "@ohos.util.ArrayList"

export class ListAdapter<T> implements IDataSource {
    private listeners: ArrayList<DataChangeListener> = new ArrayList()
    private data: ArrayList<T> = new ArrayList()

    totalCount(): number {
        return this.data.length
    }

    isEmpty(): boolean {
        return this.data.length <= 0
    }

    getData(index: number): T {
        return this.data[index]
    }

    addData(data: T, autoFlush: boolean = true) {
        try {
            this.data.add(data)
            if (autoFlush)
                this.notifyDataAdd(this.data.length - 1)
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    addDataWithIndex(data: T, index: number, autoFlush: boolean = true) {
        try {
            this.data.insert(data, index)
            if (autoFlush)
                this.notifyDataAdd(index)
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    addDataList(list: Array<T>, autoFlush: boolean = true) {
        list.forEach((data) => {
            this.addData(data, autoFlush)
        })
    }

    clear(autoFlush: boolean = true) {
        try {
            this.data.clear()
            if (autoFlush)
                this.notifyDataReload()
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    removeData(data: T, autoFlush: boolean = true) {
        try {
            let index = this.data.getIndexOf(data)
            if (index >= 0) {
                this.data.remove(data)
                if (autoFlush)
                    this.notifyDataDelete(index)
            }
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    notifyDataAdd(index: number) {
        try {
            this.listeners.forEach((listener) => {
                listener.onDataAdd(index)
            })
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    notifyDataDelete(index: number) {
        try {
            this.listeners.forEach((listener) => {
                listener.onDataDelete(index)
            })
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    notifyDataReload() {
        try {
            this.listeners.forEach((listener) => {
                listener.onDataReloaded()
            })
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    registerDataChangeListener(listener: DataChangeListener) {
        try {
            if (!this.listeners.has(listener))
                this.listeners.add(listener)
        } catch (error) {
            // TODO: Implement error handling.
        }
    }

    unregisterDataChangeListener(listener: DataChangeListener) {
        try {
            this.listeners.remove(listener)
        } catch (error) {
            // TODO: Implement error handling.
        }
    }
}