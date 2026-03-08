import { useEffect } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

import { HomeScreen } from './src/screens/HomeScreen';
import { RecordScreen } from './src/screens/RecordScreen';
import { MapScreen } from './src/screens/MapScreen';
import { TrailsScreen } from './src/screens/TrailsScreen';
import { initDbAsync } from './src/storage/db';

// Registers the background task (must be imported at top-level)
import './src/tracking/locationTask';

export type RootStackParamList = {
  Home: undefined;
  Record: undefined;
  Map: undefined;
  Trails: undefined;
};

const Stack = createNativeStackNavigator<RootStackParamList>();

export default function App() {
  useEffect(() => {
    void initDbAsync();
  }, []);

  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} options={{ title: 'Mountainr' }} />
        <Stack.Screen name="Record" component={RecordScreen} options={{ title: 'Record' }} />
        <Stack.Screen name="Map" component={MapScreen} options={{ title: 'Map' }} />
        <Stack.Screen name="Trails" component={TrailsScreen} options={{ title: 'Discover Trails (OSM)' }} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
