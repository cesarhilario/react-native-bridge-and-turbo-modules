import React, { useEffect, useMemo, useState } from 'react';
import {
  Alert,
  Button,
  NativeModules,
  NativeEventEmitter,
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
} from 'react-native';

import RTNCalculator from 'rtn-calculator/js/NativeCalculator';

interface NativeError {
  code: string | number;
  message: string;
}

// Instantiate the event emitter
const CounterWithEvents = new NativeEventEmitter(
  NativeModules.CounterWithEvents,
);

export const Home = () => {
  const [constants, setConstants] = useState({});
  const [counter, setCounter] = useState(
    // NativeModules.Counter.getConstants().initialCount,
    0,
  );
  const [result, setResult] = useState<number | null>(null);

  const getConstants = () => {
    setConstants(NativeModules.Counter.getConstants());
  };

  const increment = () => {
    NativeModules.Counter.increment();
    getCount();
  };

  const getCount = () => {
    NativeModules.Counter.getCount((value: unknown) => {
      setCounter(value);
    });
  };

  const decrement = async () => {
    try {
      await NativeModules.Counter.decrement();
      getCount();
    } catch (error) {
      console.log(error);
      Alert.alert(
        'An error ocurred',
        `${(error as NativeError).code}: ${(error as NativeError).message}`,
      );
    }
  };

  const decrementWithThen = () => {
    NativeModules.Counter.decrement()
      .then((res: unknown) => console.log(res))
      .catch((error: NativeError) => {
        Alert.alert('An error ocurred', `${error.code}: ${error.message}`);
      });
    getCount();
  };

  const callbackMethodWithArguments = () => {
    NativeModules.Counter.callbackMethodWithArguments(
      (count: unknown, ...otherArguments: unknown[]) => {
        console.log('The count is: ', count);
        console.log('Other arguments', otherArguments);
      },
    );
  };

  const incrementWithEvents = () => {
    NativeModules.CounterWithEvents.increment();
  };

  // subscribe to the event
  const onIncrementListener = useMemo(
    () =>
      CounterWithEvents.addListener('onIncrement', result => {
        setCounter(`from "onIncrement" event: ${JSON.stringify(result.count)}`);
        console.log('onIncrement event', result);
      }),
    [],
  );

  useEffect(() => {
    () => {
      onIncrementListener.remove();
    };
  }, [onIncrementListener]);

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView>
        <Text>Constants: {JSON.stringify(constants, null, 2)}</Text>
        <Button title="Get constants" onPress={getConstants} />
        <Text>Counter: {counter}</Text>
        <Button title="Increment [Calling Native Method]" onPress={increment} />
        <Button
          title="Increment [Calling Event Emitter Event]"
          onPress={incrementWithEvents}
        />
        <Button title="Decrement [Promise async/await]" onPress={decrement} />
        <Button
          title="Decrement [Promise with Then] [See the console]"
          onPress={decrementWithThen}
        />
        <Button title="GetCount [Callback]" onPress={getCount} />
        <Button
          title="Callback with arguments [See the console]"
          onPress={callbackMethodWithArguments}
        />
        <Text>Turbo Modules</Text>
        <Text style={{ marginLeft: 20, marginTop: 20 }}>
          3+7={result ?? '??'}
        </Text>
        <Button
          title="Compute"
          onPress={() => {
            const value = RTNCalculator?.add(3, 7);
            if (value) {
              setResult(value);
            }
          }}
        />
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    width: '100%',
    height: '100%',
  },
});
